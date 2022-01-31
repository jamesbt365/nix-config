{ config, pkgs, ... }:
let
  # this may or may not work?
  super = "Mod4";
  alt = "Mod1";
in {
    services.sxhkd = {
    enable = true;
    keybindings = {
        # Terminal
        "super + Return" = " kitty";

        # rofi
        "super + p" = "rofi -show-icons -show drun";

        # Screenshot
        "Print" = "flameshot gui";

        # restart sxhkd
        "super + Escape" = "pkill -USR1 -x sxhkd";

        # kill the selected window
        "super + {_,shift + }w" = "bspc node -{c,k}";

        # switch between tiled, floating and fullscreen
        "super + {t,s,f}" = "bspc node -t {tiled,floating,fullscreen}";

        # select the next monitor
        "super + ctrl + n" = "bspc monitor -f next";

        # focus or send to the given desktop
        "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";

        # focus the next/previous window in the current desktop
        "super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";

        # Exit / Restart bspwm
        "super + shift + {q,r}" = "bspc {quit,wm -r}";
    };
};
}