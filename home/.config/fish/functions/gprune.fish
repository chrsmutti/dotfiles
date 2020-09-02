function gprune
    echo "Running 'git remote prune origin'"
    git remote prune origin

    echo "Running 'git branch --merged'"
    set branches (git branch --merged)

    for branch_old in $branches
        set branch (echo $branch_old | perl -ne 's/^\*?\s+//g; print;')
        if test "$branch" = 'master'; or test "$branch" = 'develop'
            echo "Skipping branch $branch"
            continue
        end

        read -l -P "Do you want to delete branch $branch? [Y/n] " confirm
        if test -z "$confirm"; or test "$confirm" = 'y'; or test "$confirm" = 'Y'
            git branch -d $branch
        end
    end
end