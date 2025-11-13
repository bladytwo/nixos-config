# My Nixos Config

This is my nixos configuration with swaywm and home-manager.
Currently it contains one host that is hubadic (i.e. personal computer).

Change it to your liking.

## How to install.

### hubadic

```command
sudo nixos-rebuild switch --flake <repo-dir>#hubadic
```

### user (nullen)

```command
home-manager switch --flake <repo-dir> -b backup
```
