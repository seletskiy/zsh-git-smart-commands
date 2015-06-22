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
