# Info 📰

...

## Installation 🛠️

- Clone the repository and open a terminal inside it:

   ```shell
   git clone <url>
   cd <name
   ```

- see [./hosts](./hosts) for the list of `<host>` possibilities and setup the current system hardware for it:

   ```shell
   sudo nixos-generate-config --dir ./hosts/<host>
   ```

- Enable flakes, if not already enabled:

   ```shell
   sudo sed -i '/^}$/i\  nix.settings.experimental-features = [ "nix-command" "flakes" ];' /etc/nixos/configuration.nix
   sudo nixos-rebuild switch
   ```

- Replace all appearances of the default username with the desired one:

   ```shell
   find . -path ./\.git -prune -o -type f -exec sed -i 's/dy0gu/<username>/g' {} +
   ```

- Pick the same `<host>` from the hardware setup to build into:

   ```shell
   sudo nixos-rebuild switch --flake .#<host>
   ```

- Update from the initial password to a secure one:

   ```shell
   sudo passwd <username>
   ```
