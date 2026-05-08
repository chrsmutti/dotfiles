function git-cleanup-gone --description "Force-delete local branches whose remote is gone"
    set -l gone_branches (git branch -vv | string match -rv '^[*+]' | string match -r '\S+(?=.*: gone\])')

    if test (count $gone_branches) -eq 0
        echo "No gone branches to delete"
        return 0
    end

    for branch in $gone_branches
        git branch -D $branch
    end
end
