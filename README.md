# ThinkPad configurations

NixOS configurations for `t14` and `t15`, plus a standalone Home Manager
configuration for the `kriive` user in `pwnbox`. Dependencies are pinned in
`flake.lock`.

## Layout

| Location | Responsibility |
| --- | --- |
| `flake.nix` | Inputs, host construction, development shells, package outputs, and checks |
| `hosts/<host>/` | Hardware, selected profiles, host-specific power/input settings, and Home Manager overrides |
| `nixos/` | Explicit base, laptop, desktop, container, and hardening profiles |
| `home/kriive.nix`, `home/pwnbox.nix` | User identity and selected Home Manager profiles |
| `home/profiles/` | Shell utilities, development tools, desktop applications, and pwn tools |
| `home/programs/` | Individual application settings |
| `pkgs/` | Custom packages and the shared pwn package list |
| `overlays/` | Package-set modifications |
| `docs/workarounds.md` | Compatibility exceptions, their scope, and removal conditions |

Keep hardware differences in the host directory. Select features through imports.
Add a custom option when a profile needs a real host-specific value, such as the
Incus bridge address. Keep `system.stateVersion` and `home.stateVersion` tied to
the installation; they are not dependency versions.

## Validate and build

After adding new files, make them visible to Git before using the flake:

```sh
git add -N .
nix fmt
nix flake check --no-build
nix build --no-link .#checks.x86_64-linux.formatting .#checks.x86_64-linux.lint
```

The evaluation check covers both hosts, the development shells, and the standalone
Home Manager activation package through `checks.x86_64-linux.pwn-home`.
`nix flake check` also builds the checks, including that activation package.

Build a system without activating it:

```sh
nix build .#nixosConfigurations.t14.config.system.build.toplevel
```

For an intentional deployment, after reviewing the build:

```sh
sudo nixos-rebuild switch --flake .#t14
```

Use `t15` for the other machine. Before the first T15 deployment after this
refactor, compare `incus network get incusbr0 ipv4.address` with
`local.containers.ipv4Address` in `hosts/t15/default.nix`. Its configured subnet
comes from the previous proxy address; the live T15 subnet was not available
during the refactor. T14's setting preserves its verified live subnet.

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

## Pwn environment

`cloud-init.yaml`, `home/pwnbox.nix`, and the `pwnbox` shell alias all use
`kriive` and `/home/kriive`. Cloud-init creates the account and installs Git and
curl; installing Nix and applying Home Manager are separate bootstrap steps.

After installing Nix inside the container and checking out the repository:

```sh
nix build .#homeConfigurations.pwn.activationPackage
./result/activate
```

Run activation as `kriive`. The profile configures Fish for interactive use;
the cloud-init login shell remains Bash. Container provisioning and container
data are not managed by the host's Home Manager activation.

## Development and updates

```sh
nix develop             # Nix formatter and language/lint tools
nix develop .#homelab   # Kubernetes/Talos tools
nix develop .#pwn       # Reverse-engineering tools
nix flake update
nix flake check --no-build
```

Review `docs/workarounds.md` with every dependency update. T14 checks the exact
kernel version reviewed with its local touchpad patches. If an update changes
it, review the patches, update `testedKernelVersion` in
`hosts/t14/touchpad.nix`, and build:

```sh
nix build --no-link .#t14-kernel
```

Then build the full system and verify touchpad operation and suspend/resume on
the hardware before considering that kernel tested. Package evaluation does not
check patch application or runtime behavior.
