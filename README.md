# Automated Installation of Zsh + Oh My Zsh

This repository contains scripts to automate the installation of [Zsh](https://www.zsh.org/), [Oh My Zsh](https://ohmyz.sh/), and popular plugins on Debian/Ubuntu-based systems.

## What does the script do?

1. **Removes old installations** of Zsh, Oh My Zsh, and configuration files (`zsh-purge.sh`).
2. **Installs dependencies**: `git` and `curl`.
3. **Installs Zsh** and sets it as the default shell.
4. **Installs Oh My Zsh** without starting a new session automatically.
5. **Installs plugins**:
   - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
   - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
   - Other useful plugins already configured in `.zshrc`.
6. **Updates `.zshrc`** to enable the plugins.
7. **Starts a new Zsh session** to apply the changes.

## How to use

```sh
chmod +x zsh.sh zsh-purge.sh
./zsh.sh
```