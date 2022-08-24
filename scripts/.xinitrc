if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval $(dbus-launch --exit-with-session --sh-syntax)
fi
systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment > /dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi

setxkbmap -model pc104 -layout gb,gb -variant dvorak,
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 144.00 --left-of eDP --primary --output eDP --mode 1920x1080 --rate 60
# will this work when i deploy?, its not ideal but it may work.
exec bspwm
