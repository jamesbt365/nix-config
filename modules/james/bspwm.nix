{ config, ... }: { 
    xsession.windowManager.bspwm = {
        enable = true;
        monitors = { 
            eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
            HDMI-A-0 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
            # i'm on a vm so i hope this works when i deploy, but its a lazy? way of doing
            # it saying this changes between machine but uhhh, i don't know i'll fix later.
        };
        settings = {
            window_gap = 5;
            border_width = 3;
            split_ratio = 0.5;
            top_padding = 32; # i'll adjust later.
            normal_border_color = "#000000";
            focused_border_color = "#5D3FD3";
            normal_urgent_color = "#ff0000";
        };
        extraConfig = ''
        # do something else other than this method.
        sxhkd &
        xsetroot -cursor_name left_ptr &
        polybar bar1 &
        polybar bar2 &
        exec --no-startup-id /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
        # TODO fix polybar from starting early by restarting it here ig
        '';
    };
}
