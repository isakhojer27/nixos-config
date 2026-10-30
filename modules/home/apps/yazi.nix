{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y"; # starta med `y`, hamna i mappen du lämnade

    plugins = {
      smart-enter = pkgs.yaziPlugins.smart-enter;
    };

    settings = {
      mgr = {
        show_hidden = false;
        sort_by = "natural";
        sort_dir_first = true;
      };

      opener = {
        image = [
          { run = "imv %s"; desc = "imv"; orphan = true; }
        ];
        video = [
          { run = "vlc %s"; desc = "VLC"; orphan = true; }
        ];
        pdf = [
          { run = "zen %s"; desc = "Zen"; orphan = true; }
        ];
        edit = [
          { run = "$EDITOR %s"; desc = "Redigera"; block = true; }
        ];
        office = [
          { run = "euro-office-desktopeditors %s"; desc = "eurooffice"; orphan = true; }
          { run = "xdg-open %s1"; desc = "sys"; orphan = true; }
        ];
        fallback = [
          { run = "xdg-open %s1"; desc = "sys"; orphan = true; }
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
        { on = [ "<Enter>" ]; run = "plugin smart-enter"; desc = "öppna"; }

        { on = [ "<C-c>" ]; run = "yank";       desc = "Kopiera"; }
        { on = [ "<C-x>" ]; run = "yank --cut"; desc = "Klipp ut"; }
        { on = [ "<C-v>" ]; run = "paste";      desc = "Klistra in"; }
        { on = [ "<C-o>" ]; run = "spot";       desc = "Egenskaper"; }

        { on = [ "<C-r>" ];      run = "rename";               desc = "Döp om"; }
        { on = [ "<F2>" ];       run = "rename";               desc = "Döp om"; }
        { on = [ "<Delete>" ];   run = "remove";               desc = "trash"; }
        { on = [ "<S-Delete>" ]; run = "remove --permanently"; desc = "radera"; }
        { on = [ "<C-n>" ];      run = "create";               desc = "Ny fil/mapp"; }

        { on = [ "<C-a>" ]; run = "toggle_all --state=on"; desc = "Markera allt"; }

        { on = [ "<C-f>" ];       run = "find";             desc = "Sök"; }
        { on = [ "<C-l>" ];       run = "cd --interactive"; desc = "Gå till sökväg"; }
        { on = [ "<Backspace>" ]; run = "leave";            desc = "Upp en nivå"; }
      ];
    };
    initLua = ''
      local last = { time = 0, idx = 0 }
      local press = nil

      function Current:click(event, up)
        if event.is_middle then return end
        local f = self._folder
        local y = event.y - self._area.y + 1
        local file = f.window[y]
        if not file then press = nil; return end
        local idx = y + f.offset

        -- Musknapp nedtryckt
        if not up then
          ya.emit("arrow", { idx - f.hovered.idx })
          if event.is_right then
            ya.emit("open", { hovered = true })
            return
          end
          press = idx
          local now = ya.time()
          if last.idx == idx and now - last.time < 0.4 then
            last.time = 0
            if file.cha.is_dir then
              ya.emit("enter", {})
            else
              ya.emit("open", { hovered = true })
            end
          else
            last.time, last.idx = now, idx
          end
          return
        end

        -- Musknapp släppt på en annan rad: markera intervallet
        if press and idx ~= press then
          ya.emit("visual_mode", {})
          ya.emit("arrow", { idx - press })
          ya.emit("escape", { visual = true })
        end
        press = nil
      end
    '';
  };

  home.packages = with pkgs; [
    imv
    trash-cli
  ];
}
