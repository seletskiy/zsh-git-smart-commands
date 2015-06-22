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

compdef _git-smart-commit git-smart-commit
function _git-smart-commit() {
    service="git-commit" _git "${@}"
}

compdef _git-smart-add git-smart-add
function _git-smart-add() {
    service="git-add" _git "${@}"
}
