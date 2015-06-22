# zsh-git-smart-commands

Wrappers for common git commands so they can be used in the aliases very
efficiently.

All commands comes with default git completion.

# Installation

## zgen

```zsh
zgen load seletskiy/zsh-git-smart-commands
```

## git-smart-commit

With arguments same as `git commit -m`. Without argumenst behaves like `git
commit -v`.

Also, removes necessity of quotes around commit message.

```zsh
alias c='git-smart-commit'
```

Then, commits can be done via:

```zsh
c my supper commit message
```

Autocompletion always works:

```zsh
c my blah blah --am<TAB>
# ==> c my blah blah --amend
```

**Note**: quotes are not mandatory now.

## git-smart-add

```zsh
alias a='git-smart-add'
```

Without arguments will add all files in the repo to the index. Otherwise will
act as specified in commmand line.
