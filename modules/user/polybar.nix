{ config, ... }: {
    services.polybar = {
        enable = true;
        settings = {
            "bar/HDMI" = {
            monitor = "HDMI-A-0";
            width = "100%";
            height = 30;
            background = "#181818";
            # i got bored, time for normal dotfile.
        };
    };
}