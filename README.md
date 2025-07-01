# Info 📰

...

## Installation 🛠️

1. Generate only the hardware configuration for the current system:

   ```shell
   sudo nixos-generate-config --dir ./modules/devices
   rm ./modules/devices/configuration.nix
   ```

2. Enable flakes, if not already enabled:

   ```shell
   sudo sed -i '/^}$/i\  nix.settings.experimental-features = [ "nix-command" "flakes" ];' /etc/nixos/configuration.nix
   sudo nixos-rebuild switch
   ```

3. Build (pick one) and switch:

   ```shell
   sudo nixos-rebuild switch --flake .#server
   ```

   ```shell
   sudo nixos-rebuild switch --flake .#laptop
   ```

4. Replace all appearances of the default username with the desired one:

   ```shell
   find . -path ./\.git -prune -o -type f -exec sed -i 's/dy0gu/<username>/g' {} +
   ```

5. Update from the initial password to a secure one:

   ```shell
   sudo passwd <username>
   ```
