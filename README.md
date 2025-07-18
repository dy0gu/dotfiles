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

- Replace appearances of the existing username with the new (`<username>`) one, in every file:

   ```shell
   find . -type f -name '*dy0gu*' -exec bash -c 'for f; do mv "$f" "${f//dy0gu/}"; done' bash {} + # for appearances in file names

   find . -path ./\.git -prune -o -type f -exec sed -i 's/dy0gu/<username>/g' {} + # for appearances inside files
   ```

   If you want to add new users and not just replace the default one, then add them in [modules/core/users.nix](./modules/core/users.nix) file and create the respective [modules/home-manager](./modules/home-manager) config. This user config should then be loaded it in the `flake.nix` file for the desired `<host>`.

- Build and switch to the same `<host>` from the previous hardware configuration step, with `<cores>` as a number lower than your maximum CPU cores, to prevent running out of RAM from paralelism:

   ```shell
   sudo nixos-rebuild switch --cores <cores> --flake .#<host>
   ```

- You might see a `git tree is dirty warning` during the build process. This usually happens after running `nixos-generate-config` and staging the generated file with `git add`, but not pushing it to the remote repository, which leaves your local changes uncommitted from the remote’s perspective. If you plan on keeping the configuration you should:

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

- Having the `gh` and `glab` CLI packages installed allows for easy authentication with GitHub and GitLab, respectively. You can use them if you prefer an `https` login over setting up SSH keys again.

  - You first have to set `git config --global user.name` and `git config --global user.email` manually, as these are not set by default to keep the repository clean of personal data.

  - Then simply run `gh auth login` or `glab auth login` and follow the prompts to authenticate and let the CLIs setup your local git protocols/credentials automatically.

- The **Firefox** profile configuration is very basic as it expects most of the settings to come from cloud syncing, which is not configured in this repository (again, keeping it clean of personal data). You can set up cloud sync from inside the browser itself after the initial setup. The sync server for Firefox is also self-hostable.

- The icon distributions in the GNOME app menu is not handled in Nix because this would require locking it to a specific state, which prevents newly installed apps from being added there by GNOME. This requires more work than it is worth so icon ordering is untouched for the user to handle manually.
