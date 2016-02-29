function git-smart-commit() {
    if [ $# -eq 0 ]; then
        git commit -v
    else
        flags=()
        while grep -q "^-" <<< "$1"; do
            flags+=("$1")
            shift
        done

        git commit "${flags[@]}" -m "$(echo "${@}")"
    fi
}

function git-smart-add() {
    if [ $# -eq 0 ]; then
        git add .
    else
        git add "${@}"
    fi
}

function git-smart-push() {
    if git remote show -n | grep -qF "$1"; then
        remote="$1"
        shift
        git push $remote "${@}"
    else
        shift
        git push origin "${@}"
    fi
}

function git-smart-pull() {
    if [ "$(git status -s)" ]; then
        git stash -u
        git pull "${@}"
        git stash pop
    else
        git pull "${@}"
    fi
}

function git-smart-remote() {
    if [ "$(git remote show -n)" ]; then
        git remote "${@}"
    else
        git remote add origin "${@}"
    fi
}
