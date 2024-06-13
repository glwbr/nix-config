{config, ...}: {
  programs.yazi = {
    settings = {
      manager = {
        layout = [1 4 3];
        sort_by = "alphabetical";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "${config.xdg.cacheHome}";
      };

      theme.manager = {
        # Find
        find_keyword = {
          italic = true;
        };

        find_position = {
          bg = "reset";
          italic = true;
        };

        # Tab
        tab_width = 1;

        # Border;
        border_symbol = "│";

        # Offset;
        folder_offset = [1 0 1 0];
        preview_offset = [1 1 1 1];
      };
    };
  };
}
