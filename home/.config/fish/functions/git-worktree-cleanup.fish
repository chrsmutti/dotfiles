function git-worktree-cleanup --description "List worktrees with merged branches"
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "Not in a git repository"
        return 1
    end

    set -l main_root (git rev-parse --show-toplevel)
    set -l default_branch main

    # try to detect the default branch
    if git show-ref --verify --quiet refs/heads/main
        set default_branch main
    else if git show-ref --verify --quiet refs/heads/master
        set default_branch master
    end

    echo "Current worktrees:"
    git worktree list

    echo ""
    echo "Worktrees with merged branches (safe to remove):"

    set -l current_wt ""
    set -l found 0
    for line in (git worktree list --porcelain)
        if string match -q "worktree *" -- $line
            set current_wt (string replace "worktree " "" -- $line)
        else if string match -q "branch *" -- $line
            set -l branch (string replace "refs/heads/" "" -- (string replace "branch " "" -- $line))
            # skip the main worktree
            if test "$current_wt" = "$main_root"
                continue
            end
            if git merge-base --is-ancestor $branch $default_branch 2>/dev/null
                echo "  $current_wt ($branch)"
                set found 1
            end
        end
    end

    if test $found -eq 0
        echo "  none"
    end

    echo ""
    echo "To remove a worktree:        git worktree remove <path>"
    echo "To force-remove (with WIP):  git worktree remove --force <path>"
end
