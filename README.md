# .files 🗄️

The first time I tried **NixOS** I immediately fell in love with its declarative configuration and reproducibility. It was like something I had always been looking for but never knew existed.

Since then, I have been using it as the main operating system in most of my machines and _slowly_ iterating on their configurations.

This repository holds the collection of all those configurations, for
a multitude of hosts, completely bundled into a flake.

## Forking + Customization 🎨

There are no detailed instructions for forking and customizing this repository for yourself at the moment, since it's primarily maintained for personal use. However, you're welcome to adapt it for your own setup.

If you want to, the main things that would need to be changed are the user profile and home configurations for each host, so the system is personalized to your username(s). You should do this before the initial `nixos-rebuild switch` command, since some changes at the system/users level can leave remnants of the previous profiles.

## Installation 🛠️

It is recommeded that NixOS is installed using the official [graphical image](https://nixos.org/download/#nixos-iso), with the **allow unfree software** option enabled and **No Desktop** chosen in the installer.

This next section assumes you already have a NixOS itself installed and understand basic Linux commands.

The instructions here target the minimal configuration left after the NixOS installer is ran, but they should work with any existing setup, since it will be overwritten.

> [!NOTE]
> Once `flakes` leave experimental state this first step is no longer needed and should be skipped, whenever that may be.

- Enable the `flakes` experimental feature.

  - Add this line to the existing initial configuration, which can be edited using `sudo nano /etc/nixos/configuration.nix`, since `nano` is installed by default:

      ```nix
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      ```

  - Rebuild with flakes now enabled:

     ```shell
     sudo nixos-rebuild switch
     ```

- Start a temporary Nix shell with `git` available:

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

- Build and switch to the same `<host>` from the previous hardware configuration step, with `<cores>` as a number lower than your maximum CPU cores, to prevent [running out of RAM](https://github.com/NixOS/nix/pull/11143) from paralelism:

   ```shell
   sudo nixos-rebuild switch --option cores <cores> --option max-jobs <cores> --flake .#<host>
   ```

- You might see a `git tree is dirty warning` during the build process. This is the flake warning you that you have `git add`-ed changes but still haven't `git push`-ed them to the remote repository for safekeeping.

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
