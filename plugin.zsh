git-smart-commit() {
    if [ $# -eq 0 ]; then
        git commit -v
    else
        local flags=()
        local amend=false

        while grep -q "^-" <<< "$1"; do
            flags+=("$1")

            if [[ "$1" == "--amend" ]]; then
                amend=true
            fi

            shift
        done

        if [ "$(git status --porcelain | cut -b1 | awk '$1')" = "" ]; then
            if ! $amend; then
                git add -A
                git status -s
            fi
        fi

        local message="$(echo "${@}")"
        if [ ${#message} -ge 50 ]; then
            flags+=(-e)
        fi

        if [[ -n "$message" ]]; then
            git commit -v "${flags[@]}" -m "$message"
        else
            git commit -v "${flags[@]}"
        fi
    fi
}

git-smart-add() {
    if [ $# -eq 0 ]; then
        git add .
    else
        git add "${@}"
    fi
}

git-smart-push() {
    local branch_name=$(git symbolic-ref --short HEAD)

    if ! git config branch.$branch_name.remote >&-; then
        if [ $# -eq 1 ]; then
            PUSH_FLAGS=(--set-upstream) _push-to-or-origin "${@}" $branch_name
        else
            PUSH_FLAGS=(--set-upstream) _push-to-or-origin "${@}"
        fi
    else
        _push-to-or-origin "${@}"
    fi
}

_push-to-or-origin() {
    local custom_origin="$1"
    shift

    if git remote show -n | grep -qF "$custom_origin"; then
        git push $PUSH_FLAGS "$custom_origin" "${@}"
    else
        git push $PUSH_FLAGS origin "${@}"
    fi
}

git-smart-pull() {
    if [ "$(git status -s)" ]; then
        git stash
        git pull "${@}"
        git stash pop
    else
        git pull "${@}"
    fi

    git submodule status \
        | awk '{print $2}' \
        | xargs -P10 -n1 git submodule update --init

    #git submodule init
    #git submodule update
}

git-smart-remote() {
    if [ "$(git remote show -n)" ]; then
        git remote "${@}"
    else
        git remote add origin "${@}"
    fi
}

git-smart-checkout() {
    if [[ -e "$1" ]]; then
        git checkout -- "${@}"
    else
        git checkout "${@}"
    fi
}

autoload -U _git-smart-checkout
autoload -U _git-smart-add
autoload -U _git-smart-commit
autoload -U _git-smart-push
autoload -U _git-smart-pull
autoload -U _git-smart-remote

compdef _git-smart-checkout git-smart-checkout
compdef _git-smart-add git-smart-add
compdef _git-smart-commit git-smart-commit
compdef _git-smart-push git-smart-push
compdef _git-smart-pull git-smart-pull
compdef _git-smart-remote git-smart-remote
