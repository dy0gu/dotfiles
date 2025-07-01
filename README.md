# Installation 🛠️

Hardware configuration is automatically picked up from `/etc/nixos/hardware-configuration.nix`, since all fresh installs will have it generated there, making this config agnostic to the initial hardware setup.

1. Build (pick one) and switch:

   ```shell
   sudo nixos-rebuild switch --flake .#server
   ```

   ```shell
   sudo nixos-rebuild switch --flake .#laptop
   ```

2. Update from the initial password to a secure one:

   ```shell
   sudo passwd <username>
   ```
