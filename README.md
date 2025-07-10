# Info 📰

...

## Installation 🛠️

This section assumes you already have a NixOS itself installed and understand basic Linux commands.

The instructions target the minimal configuration provided by the official NixOS installer as a base, but they should work with any existing setup, since it will be overwritten.

Some steps may be skipped when installing on more advanced existing configurations, as noted throughout.

> [!NOTE]
> Once `flakes` leave experimental state this first step is no longer needed and will be deleted, whenever that may be.

- Enable the `flakes` experimental feature *or* skip this step if already enabled.

  - Add this line to your existing configuration, which can be edited using `sudo nano /etc/nixos/configuration.nix` on a minimal install:

      ```nix
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      ```

  - Rebuild with flakes now enabled:

     ```shell
     sudo nixos-rebuild switch
     ```

- Start a temporary Nix shell with `git` available *or* skip this step if it is already installed.

   ```shell
   nix-shell -p git
   ```

- Clone the repository to your home directory and open a terminal inside it:

   ```shell
   git clone <url> ~/.dotfiles
   cd ~/.dotfiles
   ```

- See [hosts](./hosts) for the list of `<host>` possibilities and then setup the current system hardware for it:

   ```shell
   sudo nixos-generate-config --dir ./hosts/<host>
   git add . # flakes require all modified files to be tracked by git or they will be ignored
   ```

- Replace the home config for the new user and replace all appearances of the existing username with a new one:

   ```shell
   mv ./modules/home-manager/dy0gu.nix ./modules/home-manager/<username>.nix

   find . -path ./\.git -prune -o -type f -exec sed -i 's/dy0gu/<username>/g' {} +
   ```

   If you want to add new users and not just replace the default one, then add them in [modules/core/users.nix](./modules/core/users.nix) file and create the respective [modules/home-manager](./modules/home-manager) config. This user config should then be loaded it in the `flake.nix` file for the desired `<host>`.

- Build and switch to the same `<host>` from the previous hardware configuration step, with `<cores>` as a number lower than your maximum CPU cores, to prevent running out of RAM from paralelism:

   ```shell
   sudo nixos-rebuild switch --cores <cores> --flake .#<host>
   ```

- When building you may get a `git tree is dirty` warning, which happens because after running `nixos-generate-config` and `git add` on the generated file you still haven't pushed it to the remote. If you plan on keeping the configuration you should:

  - Create your own fork of this repository and push the changes to it, so the hardware for your hosts is updated there.

  - If planning on using multiple hosts of the same configuration, like 2 laptops, with different hardware, you can rename/add folders in `hosts` and imports in `flake.nix` to create a `laptop-1` and `laptop-2` which can both import similar configurations with different hardware.

## Usage 🚀

This setup is made to not keep any sort of credentials or personal data in the repository, meaning SSH keys, passwords, git auth etc. should be added manually after the initial setup.

- First, and most important, don't forget to change the initial password for the default user:

   ```shell
   sudo passwd <username>
   ```

   You don't need to do this step if the user already had a password set before the initial `nixos-rebuild switch` command, as it will not be overwritten by the initial password configuration.

## Tips 💡

- The presence of the `gh` and `glab` CLIs allow for easy authentication with GitHub and GitLab, respectively. You can use them if you prefer an `https` login over setting up SSH keys again.

  - You first have to set `git config --global user.name` and `git config --global user.email` manually, as these are not set by default to keep the repository clean of personal data.

  - Then simply run `gh auth login` or `glab auth login` and follow the prompts to authenticate and setup your local git protocols.
