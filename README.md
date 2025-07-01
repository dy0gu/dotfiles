# Info 📰

...

## Installation 🛠️

- Clone the repository and open a terminal inside it:

   ```shell
   git clone <url>
   cd <name>
   ```

- Generate only the hardware configuration for the current system:

   ```shell
   sudo nixos-generate-config --dir ./modules/devices
   sudo rm ./modules/devices/configuration.nix
   ```

- Enable flakes, if not already enabled:

   ```shell
   sudo sed -i '/^}$/i\  nix.settings.experimental-features = [ "nix-command" "flakes" ];' /etc/nixos/configuration.nix
   sudo nixos-rebuild switch
   ```

- Build (pick one) and switch:

   ```shell
   sudo nixos-rebuild switch --flake .#server
   ```

   ```shell
   sudo nixos-rebuild switch --flake .#laptop
   ```

- Replace all appearances of the default username with the desired one:

   ```shell
   find . -path ./\.git -prune -o -type f -exec sed -i 's/dy0gu/<username>/g' {} +
   ```

- Update from the initial password to a secure one:

   ```shell
   sudo passwd <username>
   ```
