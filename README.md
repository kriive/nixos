# ThinkPad NixOS configuration

This repository contains the configurations for `t14`, `t15`, and the `kriive` user.
Run all commands from the repository directory.

## Add the font

The desktop needs your licensed TX-02 2.002 fonts.
Replace `/path/to/tx-02` with the folder that contains the `.otf` files:

```sh
nix store add --mode nar --name source /path/to/tx-02
```

Keep a backup outside the Nix store.
Do not add the font files to Git.

## Apply changes

Use `t15` in place of `t14` for the T15.
Correct any errors before you continue to the next step.

1. If you added files, run this command:

   ```sh
   git add -N .
   ```

2. Do the configuration checks:

   ```sh
   nix fmt
   nix flake check
   ```

3. Apply the configuration:

   ```sh
   sudo nixos-rebuild switch --flake .#t14
   ```

## Update packages

Update the package versions:

```sh
nix flake update
```

Then [apply the changes](#apply-changes).
After a kernel update, restart the laptop.
Test the touchpad.
Test suspend and resume.

If the update causes a problem, select an earlier system version from the boot menu.

## Tool environments

| Tools | Command |
| --- | --- |
| Nix | `nix develop` |
| Kubernetes and Talos | `nix develop .#homelab` |
| Reverse engineering | `nix develop .#pwn` |

## Password vaults

The default rbw profile uses the personal Bitwarden account:

```sh
rbw login
rbw list
```

The `havce` profile uses the Havce vault:

```sh
env RBW_PROFILE=havce rbw login
env RBW_PROFILE=havce rbw list
```

Each profile has its own login, local vault, and agent.
Both agents start locked with the desktop session. The first vault or SSH use
asks for the vault password in a graphical Qt pinentry dialog. DMS's polkit
dialog is separate and handles system permissions.

SSH uses the personal vault's agent by default. To use the Havce agent:

```sh
env SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/rbw-havce/ssh-agent-socket" ssh user@host
```

Store keys as SSH-key items in the matching vault, and log in to each profile
once before using it as an SSH agent. The agents lock after one hour without
use and stop at logout. Screen locking does not separately lock the vaults.
To lock them immediately:

```sh
rbw lock
env RBW_PROFILE=havce rbw lock
```

## Alternative pwn configuration

This command replaces the active Home Manager configuration for `kriive`:

```sh
home-manager switch --flake .#pwn
```

## Find settings

- `hosts/`: Settings for each laptop.
- `nixos/`: System settings.
- `home/`: User settings.

See the [maintenance notes](docs/workarounds.md) before package updates.
