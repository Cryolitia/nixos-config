{ inputs, ... }:

{
  imports = [ inputs.paneru.darwinModules.paneru ];

  services.paneru = {
    enable = true;
    settings = {
      options = {
        focus_follows_mouse = true;
        mouse_follows_focus = true;
        animation_speed = 20;
        reap_empty_workspaces = true;
        create_virtual_workspace_automatically = true;
        continuous = false;
      };
      swipe = {
        sensitivity = 0.2;
        gesture.fingers_count = 3;
      };
      bindings = {
        window_focus_west = "lalt - leftarrow";
        window_focus_east = "lalt - rightarrow";
        window_virtual_north = "lalt - uparrow";
        window_virtual_south = "lalt - downarrow";

        window_focus_north = "lalt + shift - uparrow";
        window_focus_south = "lalt + shift - downarrow";

        window_swap_west = "lalt + ctrl - leftarrow";
        window_swap_east = "lalt + ctrl - rightarrow";
        window_virtualmove_north = "lalt + ctrl - uparrow";
        window_virtualmove_south = "lalt + ctrl - downarrow";

        window_swap_north = "lalt + ctrl + shift - uparrow";
        window_swap_south = "lalt + ctrl + shift - downarrow";

        window_resize = "lalt - r";
        window_fullwidth = "lalt - f";
      };
    };
  };
}
