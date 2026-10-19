# ThinkPad configurations

NixOS configurations for `t14` and `t15`, plus an optional Pwn tools
Home Manager profile. Dependencies are pinned in `flake.lock`.

## Layout

| Location | Responsibility |
| --- | --- |
| `flake.nix` | Inputs, host construction, development shells, package outputs, and checks |
| `hosts/<host>/` | Hardware, selected profiles, host-specific power/input settings, and Home Manager overrides |
| `nixos/` | Explicit base, laptop, desktop, container, and hardening profiles |
| `home/kriive.nix`, `home/pwn.nix` | User identity and selected Home Manager profiles |
| `home/profiles/` | Shell utilities, development tools, desktop applications, and pwn tools |
| `home/programs/` | Individual application settings |
| `pkgs/` | Custom packages and the shared pwn package list |
| `overlays/` | Package-set modifications |
| `docs/workarounds.md` | Compatibility exceptions, their scope, and removal conditions |

Keep hardware differences in the host directory. Select features through imports.
Keep `system.stateVersion` and `home.stateVersion` tied to the installation;
they are not dependency versions.

## Validate and build

After adding new files, make them visible to Git before using the flake:

```sh
git add -N .
nix fmt
nix flake check --no-build
nix build --no-link .#checks.x86_64-linux.formatting .#checks.x86_64-linux.lint .#checks.x86_64-linux.pwn-home
```

The flake defines both host configurations and the development shells. The
`pwn-home` check builds the standalone Home Manager activation package as part
of `nix flake check`.

Build a system without activating it:

```sh
nix build .#nixosConfigurations.t14.config.system.build.toplevel
```

For an intentional deployment, after reviewing the build:

```sh
sudo nixos-rebuild switch --flake .#t14
```

Use `t15` for the other machine.

The allocator wrappers were removed together with global hardened-malloc
preloading. Deploy the complete system and Home Manager configuration together.
On the old running system, starting the new unwrapped applications separately
would still inherit the old allocator preload.

## Private font

TX-02 is not distributed with this repository. `pkgs/tx02-fonts.nix` uses a
fixed-output source with the hash of the existing TX-02 2.002 directory.
Evaluation works without the font; desktop builds require its contents in the
local Nix store.

With your licensed copy, add the directory containing the `.otf` files:

```sh
nix store add --mode nar --name source /path/to/tx-02
nix build --no-link .#tx02-fonts
```

For the currently pinned contents, the first command should return
`/nix/store/627w2m4fjnq73jgv0vdxx9wbv8qhzlqr-source`. A different result means
the directory contents or file modes differ. Keep a copy outside the Nix store
for recovery after garbage collection. Do not commit the fonts or publish them
to a binary cache.

## Pwn tools profile

Or switch to it directly from the repository root:

```sh
home-manager switch --flake .#pwn
```

## Development and updates

```sh
nix develop             # Nix formatter and language/lint tools
nix develop .#homelab   # Kubernetes/Talos tools
nix develop .#pwn       # Reverse-engineering tools
nix flake update
nix flake check --no-build
```

After updating the inputs, rebuild and activate T14:

```sh
sudo nixos-rebuild switch --flake .#t14
```

The rebuild applies the local touchpad patches and compiles the kernel as needed.
If patching or compilation fails, activation does not run; fix the patches and
retry. No kernel version marker needs updating. Review `docs/workarounds.md` when
updating dependencies, and remove patches once their fixes are included upstream.

After a successful rebuild, reboot to load the new kernel and test the touchpad
and suspend/resume. If behavior regresses, boot the previous generation.
Use `.#t15` instead when updating T15.

For troubleshooting, `nix build --no-link .#t14-kernel` optionally builds just the
patched kernel. A successful build cannot verify runtime behavior on the hardware.
