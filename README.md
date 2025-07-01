# Info 📰

...

## Installation 🛠️

- Clone the repository and open a terminal inside it:

   ```shell
   git clone <url>
   cd <name
   ```

- Enable flakes, if not already enabled:

   ```shell
   sudo sed -i '/^}$/i\  nix.settings.experimental-features = [ "nix-command" "flakes" ];' /etc/nixos/configuration.nix
   sudo nixos-rebuild switch
   ```

- See [./hosts](./hosts) for the list of `<host>` possibilities and then setup the current system hardware for it:

   ```shell
   sudo nixos-generate-config --dir ./hosts/<host>
   ```

- Replace all appearances of the default username with the desired one:

   ```shell
   find . -path ./\.git -prune -o -type f -exec sed -i 's/dy0gu/<username>/g' {} +
   ```

- Build and switch to the same `<host>` from the previous hardware configuration step:

   ```shell
   sudo nixos-rebuild switch --flake .#<host>
   ```

## Usage 🚀

This setup is made to not keep any sort of credentials or personal data in the repository, meaning SSH keys, passwords, git auth etc. should be added manually after the initial setup.

But first, and more important than every other, don't forget to change the initial password for the default user:

```shell
sudo passwd <username>
```
