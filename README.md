<div align="center">

# asdf-stylua [![Build](https://github.com/jc00ke/asdf-stylua/actions/workflows/build.yml/badge.svg)](https://github.com/jc00ke/asdf-stylua/actions/workflows/build.yml) [![Lint](https://github.com/jc00ke/asdf-stylua/actions/workflows/lint.yml/badge.svg)](https://github.com/jc00ke/asdf-stylua/actions/workflows/lint.yml)

[stylua](https://github.com/jc00ke/asdf-stylua) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `unzip`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add stylua
# or
asdf plugin add stylua https://github.com/jc00ke/asdf-stylua.git
```

stylua:

```shell
# Show all installable versions
asdf list-all stylua

# Install specific version
asdf install stylua latest

# Set a version globally (on your ~/.tool-versions file)
asdf global stylua latest

# Now stylua commands are available
stylua --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/jc00ke/asdf-stylua/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Jesse Cooke](https://github.com/jc00ke/)
