# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test stylua https://github.com/jc00ke/asdf-stylua.git "stylua --version"
```

Tests are automatically run in GitHub Actions on push and PR.
