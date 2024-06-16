"""Define colors and font for qutebrowser."""

import psutil


def is_picom_running() -> bool:
    """Check if picom is running."""
    for process in psutil.process_iter():
        if process.name() == "picom":
            return True
    return False


def setup(c):
    """Set up the theme."""
    base00 = "#111111"
    base01 = "#272727"
    base02 = "#504945"
    base03 = "#5a524c"
    base04 = "#bdae93"
    base05 = "#ddc7a1"
    base06 = "#ebdbb2"
    base07 = "#fbf1c7"
    base08 = "#ea6962"
    base09 = "#e78a4e"
    base0A = "#d8a657"
    base0B = "#a9b665"
    base0C = "#89b482"
    base0D = "#7daea3"
    base0E = "#d3869b"
    base0F = "#bd6f3e"

    transparent = "#cc1b1b1b"
    if not is_picom_running():
        transparent = base00

    # Set dark mode
    # c.colors.webpage.darkmode.enabled = True
    c.colors.webpage.preferred_color_scheme = "dark"
    c.window.transparent = True

    # Text color of the completion widget. May be a single color to use for
    # all columns or a list of three colors, one for each column.
    c.colors.completion.fg = base05

    # Background color of the completion widget for odd rows.
    c.colors.completion.odd.bg = base00

    # Background color of the completion widget for even rows.
    c.colors.completion.even.bg = base00

    # Foreground color of completion widget category headers.
    c.colors.completion.category.fg = base0D

    # Background color of the completion widget category headers.
    c.colors.completion.category.bg = base00

    # Top border color of the completion widget category headers.
    c.colors.completion.category.border.top = base00

    # Bottom border color of the completion widget category headers.
    c.colors.completion.category.border.bottom = base00

    # Foreground color of the selected completion item.
    c.colors.completion.item.selected.fg = base05

    # Background color of the selected completion item.
    c.colors.completion.item.selected.bg = base02

    # Top border color of the selected completion item.
    c.colors.completion.item.selected.border.top = base02

    # Bottom border color of the selected completion item.
    c.colors.completion.item.selected.border.bottom = base02

    # Foreground color of the matched text in the selected completion item.
    c.colors.completion.item.selected.match.fg = base05

    # Foreground color of the matched text in the completion.
    c.colors.completion.match.fg = base09

    # Color of the scrollbar handle in the completion view.
    c.colors.completion.scrollbar.fg = base05

    # Color of the scrollbar in the completion view.
    c.colors.completion.scrollbar.bg = base00

    # Background color of disabled items in the context menu.
    c.colors.contextmenu.disabled.bg = base01

    # Foreground color of disabled items in the context menu.
    c.colors.contextmenu.disabled.fg = base04

    # Background color of the context menu. If set to null, the Qt default is used.
    c.colors.contextmenu.menu.bg = base00

    # Foreground color of the context menu. If set to null, the Qt default is used.
    c.colors.contextmenu.menu.fg = base05

    # Background color of the context menu’s selected item. If set to null, the Qt default is used.
    c.colors.contextmenu.selected.bg = base02

    # Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
    c.colors.contextmenu.selected.fg = base05

    # Background color for the download bar.
    c.colors.downloads.bar.bg = base00

    # Color gradient start for download text.
    c.colors.downloads.start.fg = base00

    # Color gradient start for download backgrounds.
    c.colors.downloads.start.bg = base0D

    # Color gradient end for download text.
    c.colors.downloads.stop.fg = base00

    # Color gradient stop for download backgrounds.
    c.colors.downloads.stop.bg = base0C

    # Foreground color for downloads with errors.
    c.colors.downloads.error.fg = base08

    # Font color for hints.
    c.colors.hints.fg = base00

    # Background color for hints. Note that you can use a `rgba(...)` value
    # for transparency.
    c.colors.hints.bg = base0A

    # Font color for the matched part of hints.
    c.colors.hints.match.fg = base05

    # Text color for the keyhint widget.
    c.colors.keyhint.fg = base05

    # Highlight color for keys to complete the current keychain.
    c.colors.keyhint.suffix.fg = base05

    # Background color of the keyhint widget.
    c.colors.keyhint.bg = base00

    # Foreground color of an error message.
    c.colors.messages.error.fg = base00

    # Background color of an error message.
    c.colors.messages.error.bg = base08

    # Border color of an error message.
    c.colors.messages.error.border = base08

    # Foreground color of a warning message.
    c.colors.messages.warning.fg = base00

    # Background color of a warning message.
    c.colors.messages.warning.bg = base0E

    # Border color of a warning message.
    c.colors.messages.warning.border = base0E

    # Foreground color of an info message.
    c.colors.messages.info.fg = base05

    # Background color of an info message.
    c.colors.messages.info.bg = base00

    # Border color of an info message.
    c.colors.messages.info.border = base00

    # Foreground color for prompts.
    c.colors.prompts.fg = base05

    # Border used around UI elements in prompts.
    c.colors.prompts.border = base00

    # Background color for prompts.
    c.colors.prompts.bg = base00

    # Background color for the selected item in filename prompts.
    c.colors.prompts.selected.bg = base02

    # Foreground color for the selected item in filename prompts.
    c.colors.prompts.selected.fg = base05

    # Foreground color of the statusbar.
    c.colors.statusbar.normal.fg = base05

    # Background color of the statusbar.
    c.colors.statusbar.normal.bg = transparent

    # Foreground color of the statusbar in insert mode.
    c.colors.statusbar.insert.fg = base0C

    # Background color of the statusbar in insert mode.
    c.colors.statusbar.insert.bg = transparent

    # Foreground color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.fg = base0A

    # Background color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.bg = transparent

    # Foreground color of the statusbar in private browsing mode.
    c.colors.statusbar.private.fg = base0E

    # Background color of the statusbar in private browsing mode.
    c.colors.statusbar.private.bg = transparent

    # Foreground color of the statusbar in command mode.
    c.colors.statusbar.command.fg = base04

    # Background color of the statusbar in command mode.
    c.colors.statusbar.command.bg = transparent

    # Foreground color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.fg = base0E

    # Background color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.bg = transparent

    # Foreground color of the statusbar in caret mode.
    c.colors.statusbar.caret.fg = base0D

    # Background color of the statusbar in caret mode.
    c.colors.statusbar.caret.bg = transparent

    # Foreground color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.fg = base0D

    # Background color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.bg = transparent

    # Background color of the progress bar.
    c.colors.statusbar.progress.bg = base0D

    # Default foreground color of the URL in the statusbar.
    c.colors.statusbar.url.fg = base05

    # Foreground color of the URL in the statusbar on error.
    c.colors.statusbar.url.error.fg = base08

    # Foreground color of the URL in the statusbar for hovered links.
    c.colors.statusbar.url.hover.fg = base09

    # Foreground color of the URL in the statusbar on successful load
    # (http).
    c.colors.statusbar.url.success.http.fg = base0B

    # Foreground color of the URL in the statusbar on successful load
    # (https).
    c.colors.statusbar.url.success.https.fg = base0B

    # Foreground color of the URL in the statusbar when there's a warning.
    c.colors.statusbar.url.warn.fg = base0E

    # Background color of the tab bar.
    c.colors.tabs.bar.bg = "#00000000"

    # Color gradient start for the tab indicator.
    c.colors.tabs.indicator.start = base0D

    # Color gradient end for the tab indicator.
    c.colors.tabs.indicator.stop = base0C

    # Color for the tab indicator on errors.
    c.colors.tabs.indicator.error = base08

    # Foreground color of unselected odd tabs.
    c.colors.tabs.odd.fg = base03

    # Background color of unselected odd tabs.
    c.colors.tabs.odd.bg = transparent

    # Foreground color of unselected even tabs.
    c.colors.tabs.even.fg = base03

    # Background color of unselected even tabs.
    c.colors.tabs.even.bg = transparent

    # Background color of pinned unselected even tabs.
    c.colors.tabs.pinned.even.bg = transparent

    # Foreground color of pinned unselected even tabs.
    c.colors.tabs.pinned.even.fg = base03

    # Background color of pinned unselected odd tabs.
    c.colors.tabs.pinned.odd.bg = transparent

    # Foreground color of pinned unselected odd tabs.
    c.colors.tabs.pinned.odd.fg = base03

    # Background color of pinned selected even tabs.
    c.colors.tabs.pinned.selected.even.bg = transparent

    # Foreground color of pinned selected even tabs.
    c.colors.tabs.pinned.selected.even.fg = base05

    # Background color of pinned selected odd tabs.
    c.colors.tabs.pinned.selected.odd.bg = transparent

    # Foreground color of pinned selected odd tabs.
    c.colors.tabs.pinned.selected.odd.fg = base05

    # Foreground color of selected odd tabs.
    c.colors.tabs.selected.odd.fg = base05

    # Background color of selected odd tabs.
    c.colors.tabs.selected.odd.bg = transparent

    # Foreground color of selected even tabs.
    c.colors.tabs.selected.even.fg = base05

    # Background color of selected even tabs.
    c.colors.tabs.selected.even.bg = transparent

    # Background color for webpages if unset (or empty to use the theme's
    # color).
    # c.colors.webpage.bg = transparent

    # Set font
    c.fonts.default_family = "JetBrainsMono"
