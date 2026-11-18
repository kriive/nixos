# Go development

The development profile installs Go, gopls, Delve, goimports, staticcheck,
gofumpt, golangci-lint, govulncheck, gotestsum, gotests, gomodifytags, and impl.
GCC, pkg-config, and Make are available for CGO projects and the race detector.
`~/go/bin` is on the session PATH for tools installed with `go install`.

Zed uses Nix-managed gopls and Delve, formats Go on save, organizes
imports, and enables staticcheck diagnostics through gopls. Project settings
can override the user defaults. Go support is built into Zed.

Zed uses DMS's generated DankShell themes and follows the system light/dark
mode. DMS updates the colors when its theme or wallpaper changes.
It uses TX02 Nerd Font Mono at 16 px, soft wrapping, indentation guides, and
hidden inlay hints. Its interactive terminals launch zellij with the existing
fish configuration. `Ctrl+\` toggles the terminal.

Zed uses its native Helix mode and the custom `0`, `$`, `g a`, `Enter`, and `jk`
bindings from the Helix configuration. Its other Helix bindings remain built in.
`Space o` opens Zed's project file picker rather than restricting it to the
current file's directory.
Helix emulation in Zed differs from native Helix.

In Zed, use `F4` to choose a Go main or test debug target. Packages
with special build tags or arguments can supply project debug configurations.
Zed downloads its debugger shim on first use, even though Delve is preinstalled.
Child-process debugging is allowed with `nix-mineral.settings.system.yama =
"relaxed"` (`kernel.yama.ptrace_scope=1`). Reboot after first applying this setup:
the previous maximum-hardening value of 3 cannot be lowered in a running kernel.
The first live switch can therefore report a failed `systemd-sysctl` unit even
though the editors and tools were installed; reboot applies the saved value.

Useful commands from a module directory:

```sh
go test ./...
go test -race ./...
gotestsum --format testname -- ./...
go vet ./...
staticcheck ./...
golangci-lint run
govulncheck ./...
```

gopls handles standard Go formatting and imports. `gofumpt` is also installed
for projects that choose its stricter formatting; it is not forced globally.
Manage tool versions through the Nix flake rather than the editors' tool updater.
