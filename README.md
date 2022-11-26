<br>
<p align="center">
My dotfiles :)
</p>

<br>

# Installation

**1. Install** [Stow](https://github.com/aspiers/stow/).

```bash
sudo pacman -S stow
```

**2. Clone the repo**

```bash
git clone https://github.com/LuizLazaro/dotfiles.git && cd dotfiles
```

**3. Create the symlinks using stow**

```bash
stow -vt ~ archlinux
```

| :warning: | Stow does not replace your files, so in case of conflicts because it already exists, just delete the file you don't want or run the command bellow to replace the repository files by yours. |
| :-------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

```bash
stow --adopt -vt ~ archlinux
```

# Remove

```bash
stow -Dvt ~ archlinux
```

<p align="center">I hope you like it!</p>
<p align="center">:hearts:</p>
