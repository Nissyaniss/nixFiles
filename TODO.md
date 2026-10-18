# Issues found by AI that i should fix:

## sddm being bad
I need to do my quickshell greeter

## wleave lock
does not point to quickshell lock so does nothing
short term fix: point to lock -> make lock into the panel and ipc callable
long term fix: remake the wleave in quickshell

## npins
i can use only npins which i would prefer

## structure
GUI vs non-GUI. Split hosts/common into profiles a host imports:
- core/: boot, locale, timezone, nix settings, user, zsh, CLI packages, NetworkManager.
- desktop/: Hyprland, pipewire, bluetooth, xdg, quickshell, stylix, zen, GUI packages.
- Optionally gaming/ and dev/ (docker and similar).

## quickshell

## cpu
pull proc but quickshell.io might be better and i can drop QML_XHR_ALLOW_FILE_READ if so

