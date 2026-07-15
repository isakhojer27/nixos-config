{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      mgr = {
        show_hidden = false;
        sort_by = "natural";
        sort_dir_first = true;
      };

      opener = {
              image = [
                { run = ''imv "$@"''; desc = "Öppna i imv"; orphan = true; }
              ];
              video = [
                { run = ''vlc "$@"''; desc = "Öppna i VLC"; orphan = true; }
              ];
              pdf = [
                { run = ''zen "$@"''; desc = "Öppna i Zen"; orphan = true; }
              ];
              edit = [
                { run = ''$EDITOR "$@"''; desc = "Redigera"; block = true; }
              ];
              office = [
                { run = ''desktopeditors "$@"''; desc = "Öppna i OnlyOffice"; orphan = true; }
              ];
              fallback = [
                { run = ''xdg-open "$@"''; desc = "Öppna med systemets standard"; orphan = true; }
              ];
            };

      open = {
        rules = [
          { mime = "image/*"; use = "image"; }
          { mime = "video/*"; use = "video"; }
          { mime = "application/pdf"; use = "pdf"; }
          { mime = "text/*"; use = "edit"; }
          { mime = "application/json"; use = "edit"; }
          { mime = "application/vnd.openxmlformats-officedocument.*"; use = "office"; }
          { mime = "application/vnd.oasis.opendocument.*"; use = "office"; }
          { mime = "application/msword"; use = "office"; }
          { mime = "*"; use = "fallback"; }
        ];
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        { on = [ "<C-c>" ]; run = "yank";       desc = "Kopiera"; }
        { on = [ "<C-x>" ]; run = "yank --cut"; desc = "Klipp ut"; }
        { on = [ "<C-v>" ]; run = "paste";      desc = "Klistra in"; }
        { on = [ "<C-o>" ]; run = "spot";       desc = "Egenskaper"; }

        { on = [ "<C-r>" ]; run = "rename";                    desc = "Döp om"; }
        { on = [ "<F2>" ];  run = "rename";                    desc = "Döp om"; }
        { on = [ "<Delete>" ];   run = "remove";               desc = "Till papperskorg"; }
        { on = [ "<S-Delete>" ]; run = "remove --permanently"; desc = "Radera permanent"; }
        { on = [ "<C-n>" ];      run = "create";               desc = "Ny fil/mapp"; }

        { on = [ "<C-a>" ]; run = "toggle_all --state=on"; desc = "Markera allt"; }

        { on = [ "<C-f>" ]; run = "find";             desc = "Sök"; }
        { on = [ "<C-l>" ]; run = "cd --interactive"; desc = "Gå till sökväg"; }
        { on = [ "<Backspace>" ]; run = "leave";      desc = "Upp en nivå"; }

        { on = [ "<LeftClick>" ];  run = "open"; desc = "Öppna"; }
        { on = [ "<RightClick>" ]; run = "spot"; desc = "Egenskaper"; }
      ];
    };
  };

  home.packages = with pkgs; [
    imv
    trash-cli
  ];
}
