# zsh-git-smart-commands

Wrappers for common git commands so they can be used in the aliases very
efficiently.

## git-smart-commit

```
alias c='git-smart-commit'
```

Then, commits can be done via:

```
c my supper commit message
```

**Note**: quotes are not mandatory now.

## git-smart-add

```
alias a='git-smart-add'
```

Without arguments will add all files in the repo to the index. Otherwise will
act as specified in commmand line.
