# 💤 LazyVim

My presonal LazyVim configuration.

> [!IMPORTANT]
> You will need certain programs installed in your `$PATH` to ensure everything works as expected:
>
> General:
>
> - `rg` (ripgrep)
> - `fd`
> - `jq`
> - `lazygit`
>
> For building Mason dependencies:
>
> - `go`
> - `python3`
> - `rustc`
> - `cargo`
> - `gcc`
> - `cmake`
> - `gnumake`
>
> These tools are utilized by various plugins on runtime (such as telescope), but also by Mason to allow for
> automatic installation/building of certain tools.
>
> Note that even though this does list most software that is required for Mason to build almost anything, I don't
> actually use Mason for most linters, formatters or language servers and instead choose to install them manually.
> I do this because I use NixOS and building manually could sometimes lead to issues after the libraries that these
> tools required being updated. It is therefore better to make nix aware of these tools and have it install them
> for me. Additionally, installing manually can make it easier to keep these tools up to date, as they will get
> updated alongside a system update.
>
> To see which tools you will need to install, see [this file](./lua/plugins/overrides/no_mason.lua). Alternatively,
> you also modify / remove this file, which will enable the automatic Mason installation, in case you prefer that.
>
> Additionally, to get support for the Nix language, you will also need to install the dependencies listed in
> [this file](./lua/plugins/langs/nix.lua). If you don't need Nix support, feel free to remove this file.

## TODO list

- [ ] Consider adding neotest extra (might need adapter configs)
- [ ] Consider moving to regular markdownlint, since markdownlint-cli2 is hard to configure (needs file)
- [ ] Slow exit

## Template

This repository was created from the starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.
