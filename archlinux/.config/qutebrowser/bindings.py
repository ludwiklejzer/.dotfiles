"""Define keybindings for qutebrowser."""


def setup(config):
    """Set up keybindings."""
    # Restart qutebrowser configuration
    config.bind("<Alt-r>", "config-source;; message-info 'Config sourced'")

    # Open link on mpv
    config.bind(
        "<Alt-v>", "hint links spawn --detach mpv --force-window yes {hint-url}"
    )

    # Open link on mpv with audio only
    config.bind(
        "<Alt-a>",
        "hint links spawn --detach mpv --force-window yes --no-video {hint-url}",
    )

    # Open image link on feh
    config.bind(
        "<Alt-i>",
        "hint images spawn --detach curl -sk {hint-url} | feh -",
    )

    # Hint scrollable areas
    config.bind("cs", "hint focus")

    # Show Qutebroser cheatsheet
    config.bind(
        "?",
        "spawn sh -c 'nohup bspc rule -a feh -o state=floating sticky=on && \
                feh -g 1168x720 --scale-down https://raw.githubusercontent.com/qutebrowser/qutebrowser/main/doc/img/cheatsheet-big.png'",
    )

    # Go to next tab
    config.bind("<Ctrl-j>", "tab-next")

    # Go to previous tab
    config.bind("<Ctrl-k>", "tab-prev")

    # Go to next completion menu item
    config.bind("<Ctrl-n>", "completion-item-focus next", mode="command")

    # Go to previous completion menu item
    config.bind("<Ctrl-p>", "completion-item-focus prev", mode="command")

    # Clone tab and close the original (Due to bug of WebQt new version)
    config.bind("gC", "tab-clone;;tab-prev;;tab-close")

    # Close tab
    config.bind("X", "tab-close")

    # Unbind Close tab
    config.unbind("d", mode="normal")

    # Toggle statusbar
    config.bind("<Alt-s>", "config-cycle statusbar.show always never")

    # Toggle tabs
    config.bind("<Alt-t>", "config-cycle tabs.show always never")

    # Toggle statusbar and tabs
    config.bind(
        "<Alt-b>",
        "config-cycle statusbar.show always never;; \
                config-cycle tabs.show multiple never",
    )

    # Toggle developer tools
    config.bind("<f12>", "devtools")

    # OCR
    config.bind(
        "<f10>",
        "hint images spawn sh -c 'tesseract {hint-url} - -l eng | xsel -b'",
    )

    google_translate = (
        "spawn --userscript ~/.local/share/qutebrowser/userscripts/google-translate.py"
    )
    config.bind("<Alt-x>", google_translate, mode="caret")
    config.bind("<Alt-x>", google_translate)
