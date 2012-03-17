xscreensaver -nosplash &
ck-launch-session nm-applet &
eval `ck-launch-session gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,keyring`
exec /usr/bin/awesome
