
Debian
====================
This directory contains files used to package lucentd/lucent-qt
for Debian-based Linux systems. If you compile lucentd/lucent-qt yourself, there are some useful files here.

## lucent: URI support ##


lucent-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install lucent-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your lucent-qt binary to `/usr/bin`
and the `../../share/pixmaps/lucent128.png` to `/usr/share/pixmaps`

lucent-qt.protocol (KDE)

