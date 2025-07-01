# Info 📰

...

## Installation 🛠️

- Clone the repository to your home directory and open a terminal inside it:

   ```shell
   cd ~
   git clone <url>
   cd <name>
   ```

- Enable flakes:

   ```shell
   sudo sed -i '/^}$/i\  nix.settings.experimental-features = [ "nix-command" "flakes" ];' /etc/nixos/configuration.nix
   sudo nixos-rebuild switch
   ```

- See [hosts](./hosts) for the list of `<host>` possibilities and then setup the current system hardware for it:

   ```shell
   sudo nixos-generate-config --dir ./hosts/<host>
   ```

- Replace all appearances of the existing username with a new one:

   ```shell
   find . -path ./\.git -prune -o -type f -exec sed -i 's/dy0gu/<username>/g' {} +
   ```

   More users can also be added in the [modules/core/users.nix](./modules/core/users.nix) file and the respective [modules/home-manager](./modules/home-manager) config.

- Build and switch to the same `<host>` from the previous hardware configuration step:

   ```shell
   sudo nixos-rebuild switch --flake .#<host>
   ```

## Usage 🚀

This setup is made to not keep any sort of credentials or personal data in the repository, meaning SSH keys, passwords, git auth etc. should be added manually after the initial setup.

First, and most important, don't forget to change the initial password for the default user:

```shell
sudo passwd <username>
```
