function git-cleanup --description "Clean up local git branches and worktrees"
    if not git rev-parse --git-dir >/dev/null 2>&1
        echo "Not in a git repository"
        return 1
    end

    set -l protected_branches main master develop staging

    echo "Pruning worktrees..."
    git worktree prune -v

    echo ""
    echo "Fetching and pruning remotes..."
    git fetch --all --prune

    echo ""
    echo "Removing merged local branches..."
    for branch in (git branch --merged | string replace -r '^[*+]\s*' '' | string trim)
        if contains -- $branch $protected_branches
            continue
        end
        git branch -d $branch
    end

    echo ""
    echo "Branches whose remote is gone (not checked out in any worktree):"
    set -l gone_branches (git branch -vv | string match -rv '^[*+]' | string match -r '\S+(?=.*: gone\])')

    if test (count $gone_branches) -eq 0
        echo "  none"
    else
        for branch in $gone_branches
            echo "  $branch"
        end
        echo ""
        echo "To force-delete them, run:"
        echo "  git-cleanup-gone"
    end
end
