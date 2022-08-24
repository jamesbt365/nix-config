{ config, ... }: { 
    xsession.windowManager.bspwm = {
        enable = true;
        monitors = { 
            eDP = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
            HDMI-A-0 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
            };
        settings = {
            window_gap = 3;
            border_width = 3;
            split_ratio = 0.50;
            top_padding = 30;
            ignore_ewmh_struts = true;
            normal_border_color = "#000000";
            focused_border_color = "#5D3FD3";
            normal_urgent_color = "#ff0000";
            borderless_monocle = "true";
            gapless_monocle = "true";
        };
        extraConfig = ''
        sxhkd &
        xsetroot -cursor_name left_ptr &
        polybar bar1 &
        polybar bar2 &
        '';
    };
}
