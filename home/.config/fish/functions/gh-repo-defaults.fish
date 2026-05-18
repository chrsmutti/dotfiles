function gh-repo-defaults --description "Check or apply good defaults for a GitHub repository"
    # ── Help ──────────────────────────────────────────────────────────────────
    if test (count $argv) -eq 0; or contains -- $argv[1] -h --help
        echo "Usage: gh-repo-defaults <check|apply> [--repo OWNER/REPO]"
        echo ""
        echo "Checks or applies good defaults for a GitHub repository."
        echo ""
        echo "  Repository settings:"
        echo "    • Default branch: main"
        echo "    • Squash merge only (no merge commits, no rebase)"
        echo "    • Delete branches automatically after merge"
        echo "    • Auto-merge enabled (merges once all checks pass)"
        echo ""
        echo "  Branch ruleset 'gh-repo-defaults' (main):"
        echo "    • Require linear history"
        echo "    • Block force pushes"
        echo "    • Block branch deletion"
        echo ""
        echo "  Status checks (not applied automatically):"
        echo "    GitHub requires at least one named check to enable this rule."
        echo "    After setting up CI, add required checks via:"
        echo "    Settings → Rules → Rulesets → gh-repo-defaults"
        return 0
    end

    set -l cmd $argv[1]
    if not contains -- $cmd check apply
        echo "Error: Unknown subcommand '$cmd'. Use 'check' or 'apply'."
        return 1
    end

    # ── Parse --repo flag ─────────────────────────────────────────────────────
    set -l target_repo ""
    set -l i 2
    while test $i -le (count $argv)
        if test "$argv[$i]" = --repo
            set i (math $i + 1)
            if test $i -le (count $argv)
                set target_repo $argv[$i]
            else
                echo "Error: --repo requires a value (e.g., owner/repo)"
                return 1
            end
        end
        set i (math $i + 1)
    end

    # ── Dependency checks ─────────────────────────────────────────────────────
    if not command -q gh
        echo "Error: 'gh' CLI not found."
        echo "Install it with: brew install gh"
        return 1
    end

    if not gh auth status >/dev/null 2>&1
        echo "Error: Not authenticated with GitHub."
        echo "Run: gh auth login"
        return 1
    end

    # ── Resolve repo ──────────────────────────────────────────────────────────
    set -l repo
    if test -n "$target_repo"
        set repo $target_repo
    else
        set repo (gh repo view --json nameWithOwner --jq '.nameWithOwner' 2>/dev/null)
        if test $status -ne 0; or test -z "$repo"
            echo "Error: Could not detect a GitHub repository."
            echo "Run inside a git repo, or pass --repo OWNER/REPO."
            return 1
        end
    end

    echo "Repository: $repo"
    echo ""

    # ── Shared helpers ────────────────────────────────────────────────────────
    function __grd_row
        # __grd_row "Label" true|false
        if test "$argv[2]" = true
            set_color green; printf "  [✓]"; set_color normal
        else
            set_color red; printf "  [✗]"; set_color normal
        end
        echo " $argv[1]"
    end

    function __grd_step; echo -n "  $argv[1]... "; end
    function __grd_ok;   set_color green; echo "done";   set_color normal; end
    function __grd_fail; set_color red;   echo "failed"; set_color normal; end

    # ── CHECK ─────────────────────────────────────────────────────────────────
    if test $cmd = check

        # Repo settings via REST API (1 call)
        # REST fields: default_branch, allow_squash_merge, allow_merge_commit,
        #              allow_rebase_merge, delete_branch_on_merge, allow_auto_merge
        set -l r (gh api "repos/$repo" \
            --jq '(.default_branch // "none"), (.allow_squash_merge | tostring), (.allow_merge_commit | tostring), (.allow_rebase_merge | tostring), (.delete_branch_on_merge | tostring), (.allow_auto_merge | tostring)' \
            2>/dev/null)
        # r[1]=branch  r[2]=squash  r[3]=merge_commit  r[4]=rebase  r[5]=delete  r[6]=auto_merge

        # Active branch rules via ruleset rules endpoint (1 call)
        # Checks for our applied rules + optional status_checks (user-configured)
        set -l p (gh api "repos/$repo/rules/branches/main" \
            --jq '(length > 0 | tostring), ([.[] | select(.type == "required_linear_history")] | length > 0 | tostring), ([.[] | select(.type == "non_fast_forward")] | length > 0 | tostring), ([.[] | select(.type == "deletion")] | length > 0 | tostring), ([.[] | select(.type == "required_status_checks")] | length > 0 | tostring), ([.[] | select(.type == "required_status_checks")] | if length > 0 then .[0].parameters.strict_required_status_checks_policy else false end | tostring)' \
            2>/dev/null)
        # p[1]=has_rules  p[2]=linear  p[3]=no_force_push  p[4]=no_delete  p[5]=status_checks  p[6]=strict

        echo "── Repository Settings ──────────────────────────────────"
        __grd_row "Default branch is 'main'"       (test "$r[1]" = main; and echo true; or echo false)
        __grd_row "Squash merge enabled"            $r[2]
        __grd_row "Merge commits disabled"          (test "$r[3]" = false; and echo true; or echo false)
        __grd_row "Rebase merge disabled"           (test "$r[4]" = false; and echo true; or echo false)
        __grd_row "Delete branch on merge"          $r[5]
        __grd_row "Auto-merge enabled"              $r[6]
        echo ""
        echo "── Branch Ruleset: main ─────────────────────────────────"
        __grd_row "Branch has active rules"                    $p[1]
        __grd_row "Require linear history"                     $p[2]
        __grd_row "Force pushes blocked"                       $p[3]
        __grd_row "Branch deletion blocked"                    $p[4]
        echo ""
        echo "  Status checks (add via Settings → Rules → Rulesets):"
        __grd_row "Require status checks"                      $p[5]
        __grd_row "Status checks: branch must be up-to-date"   $p[6]

    # ── APPLY ────────────────────────────────────────────────────────────────
    else

        echo "── Applying Repository Settings ─────────────────────────"

        # All merge/PR settings in a single PATCH — REST API is more reliable
        # than `gh repo edit` which may vary by gh version.
        __grd_step "Configure merge strategy and PR settings"
        if printf '%s' '{"allow_squash_merge":true,"squash_merge_commit_title":"PR_TITLE","squash_merge_commit_message":"PR_BODY","allow_merge_commit":false,"allow_rebase_merge":false,"delete_branch_on_merge":true,"allow_auto_merge":true}' \
                | gh api "repos/$repo" --method PATCH --input - >/dev/null 2>&1
            __grd_ok
        else
            __grd_fail
        end

        # Default branch — check current value first, only patch if needed
        set -l cur_branch (gh api "repos/$repo" --jq '.default_branch // ""' 2>/dev/null)
        if test "$cur_branch" = main
            echo "  Default branch is already 'main', skipping."
        else
            __grd_step "Set default branch to 'main'"
            if printf '%s' '{"default_branch":"main"}' | gh api "repos/$repo" --method PATCH --input - >/dev/null 2>&1
                __grd_ok
            else
                __grd_fail
                echo "    → A 'main' branch must exist in the repo first."
            end
        end

        echo ""
        echo "── Applying Branch Ruleset: main ────────────────────────"

        # GitHub requires at least one named check in required_status_checks —
        # an empty array is rejected with HTTP 422. So we apply the structural
        # rules here and leave status checks to be wired up via the UI once CI
        # is configured.
        set -l ruleset_body '{"name":"gh-repo-defaults","target":"branch","enforcement":"active","conditions":{"ref_name":{"include":["refs/heads/main"],"exclude":[]}},"rules":[{"type":"deletion"},{"type":"non_fast_forward"},{"type":"required_linear_history"}]}'

        # Look up an existing ruleset by name so we update instead of duplicating
        set -l ruleset_id (gh api "repos/$repo/rulesets" \
            --jq '[.[] | select(.name == "gh-repo-defaults")] | if length > 0 then (.[0].id | tostring) else "" end' \
            2>/dev/null)

        # Capture stderr for useful error messages on failure
        set -l err_file (mktemp)

        if test -n "$ruleset_id"
            __grd_step "Update 'gh-repo-defaults' ruleset"
            printf '%s' "$ruleset_body" | gh api "repos/$repo/rulesets/$ruleset_id" \
                --method PUT --input - >/dev/null 2>$err_file
        else
            __grd_step "Create 'gh-repo-defaults' ruleset"
            printf '%s' "$ruleset_body" | gh api "repos/$repo/rulesets" \
                --method POST --input - >/dev/null 2>$err_file
        end

        if test $status -eq 0
            __grd_ok
        else
            __grd_fail
            for line in (cat $err_file)
                echo "    $line"
            end
        end
        rm -f $err_file

        echo ""
        set_color yellow
        echo "  ⚠ Status checks must be configured manually:"
        set_color normal
        echo "  Settings → Rules → Rulesets → gh-repo-defaults"
        echo "  Add your CI check names there once your workflows are set up."

        echo ""
        set_color green
        echo "Done! Run 'gh-repo-defaults check' to verify."
        set_color normal
    end

    functions -e __grd_row __grd_step __grd_ok __grd_fail
end
