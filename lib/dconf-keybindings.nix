{
  "org/gnome/settings-daemon/plugins/media-keys" = {
    custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6/"
    ];
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Super>n";
    command = "nautilus";
    name = "Nautilus";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    binding = "<Super>t";
    command = "flatpak run org.mozilla.Thunderbird";
    name = "Thunderbird";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
    binding = "<Super>w";
    command = "flatpak run io.gitlab.librewolf-community";
    name = "LibreWolf";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
    binding = "<Super>Return";
    command = "kitty";
    name = "Console";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
    binding = "<Primary>Escape";
    command = "gnome-system-monitor";
    name = "System monitor";
  };

  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom6" = {
    binding = "<Super>e";
    command = "flatpak run org.gnome.TextEditor";
    name = "Editor";
  };
}
