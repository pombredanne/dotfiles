bash --login -c start_gpg_agent
xscreensaver -nosplash &
ck-launch-session nm-applet &
ck-launch-session gnome-keyring-daemon --start --components=pkcs11
ck-launch-session gnome-keyring-daemon --start --components=secrets
ck-launch-session gnome-keyring-daemon --start --components=ssh
exec /usr/bin/awesome
