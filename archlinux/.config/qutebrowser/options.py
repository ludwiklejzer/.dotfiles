"""Define keybindings for qutebrowser."""

import re

from qutebrowser.api import interceptor  # type: ignore


def setup(c, config) -> None:
    """Set up general configs."""
    # Enable or not autoconfig.yml
    config.load_autoconfig(False)

    # Tabs behavior
    c.tabs.show = "multiple"

    # Favicon size
    c.tabs.favicons.scale = 0.8

    # Format to use for the title tab
    c.tabs.title.format = "{audio}{current_title}"
    c.tabs.title.format_pinned = ""

    # Tab status indicator
    c.tabs.indicator.width = 0

    # How to behave when the last tab is closed
    c.tabs.last_close = "startpage"

    # Which tab to select when the focused tab is removed
    c.tabs.select_on_remove = "last-used"

    # Statusbar behavior
    c.statusbar.show = "always"

    # Scrollbar behavior
    c.scrolling.bar = "never"

    # Auto save session
    c.auto_save.session = True

    # Load a restored tab as soon as it takes focus
    c.session.lazy_restore = True

    # Enter insert mode after loading the page focused in an editable element
    c.input.insert_mode.auto_load = True

    # Command to select a single folder in forms
    c.fileselect.folder.command = [
        "wezterm",
        "start",
        "--always-new-process",
        "ranger",
        "--choosedir={}",
    ]

    # Command to select a sing file in forms
    c.fileselect.single_file.command = [
        "wezterm",
        "start",
        "--always-new-process",
        "ranger",
        "--choosefile={}",
    ]

    # Command to select multiple files in forms
    c.fileselect.multiple_files.command = [
        "wezterm",
        "start",
        "--always-new-process",
        "ranger",
        "--choosefiles={}",
    ]

    # Rouding radius for the edges of  prompts
    c.prompt.radius = 5

    # Languages to use for spell checking
    c.spellcheck.languages = ["en-US", "pt-BR"]

    # Search engines
    c.url.searchengines = {
        "DEFAULT": "https://www.google.com/search?q={}",
        "aw": "https://wiki.archlinux.org/?search={}",
        "mw": "https://www.merriam-webster.com/dictionary/{}",
        "gi": "https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1",
        "gn": "https://news.google.com/search?q={}",
        "i": "https://www.instagram.com/explore/tags/{}",
        "m": "https://www.google.com/maps/search/{}",
        "p": "https://pry.sh/{}",
        "r": "https://www.reddit.com/search?q={}",
        "w": "https://en.wikipedia.org/wiki/{}",
        "y": "https://www.youtube.com/results?search_query={}",
        "z": "https://z-library.se/s/?q={}",
        "g": "https://www.goodreads.com/search?q={}",
        "s": "https://open.spotify.com/search/{}",
        "t": "https://trakt.tv/search?query={}",
    }
    c.aliases = {
        "adblock-toggle": "config-cycle -t content.blocking.enabled",
        "incognito": "open --private",
        "mpv": "spawn --detach mpv {url}",
        "zathura": "hint pdf spawn --detach zathura {hint-url}",
        "paywall": "open https://1ft.io/{url}",
        # "paywall": "open http://webcache.googleusercontent.com/search?q=cache:{url}",
    }

    # New tab page
    c.url.default_page = "https://lud-startpage.vercel.app/"

    # Start page
    c.url.start_pages = "https://lud-startpage.vercel.app/"

    # Completion container
    c.completion.height = "40%"
    c.completion.scrollbar.width = 0

    # Filesystem suggestion items
    c.completion.favorite_paths = []

    # When should confirm to quit
    c.confirm_quit = ["multiple-tabs", "downloads"]

    # Downloaded files position
    c.downloads.position = "bottom"

    c.downloads.remove_finished = 10000

    # Available zoom levels
    c.zoom.levels = [
        "25%",
        "33%",
        "50%",
        "60%",
        "67%",
        "75%",
        "80%",
        "90%",
        "100%",
        "110%",
        "125%",
        "150%",
        "175%",
        "200%",
        "250%",
        "300%",
        "400%",
        "500%",
    ]

    # Autoplay <video> elements
    c.content.autoplay = False

    # Ad blocking ABP-style rulesets
    c.content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt",
        "https://easylist.to/easylist/easyprivacy.txt",
        "https://raw.githubusercontent.com/mmotti/pihole-regex/master/regex.list",
        "https://raw.githubusercontent.com/bogachenko/fuckfuckadblock/master/fuckfuckadblock.txt",
        "https://raw.githubusercontent.com/Isaaker/Spotify-AdsList/main/Lists/standard_list.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badlists.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2021.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/thirdparties/easylist-downloads.adblockplus.org/easyprivacy.txt",
        # "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/thirdparties/pgl.yoyo.org/as/serverlist",
        # "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling/hosts",
        # "https://raw.githubusercontent.com/AdAway/adaway.github.io/master/hosts.txt",
        # "https://fanboy.co.nz/fanboy-problematic-sites.txt",
    ]

    # Use Brave adblock if available, or fall back to host blocking
    c.content.blocking.method = "auto"

    # A list of patterns that should always be loaded despite being ad-blocked
    c.content.blocking.whitelist = []

    # Which cookies to accept
    c.content.cookies.accept = "all"

    # Clipboard buttons
    c.content.javascript.clipboard = "access-paste"

    # Select the system text editor
    c.editor.command = ["wezterm", "start", "--always-new-process", "nvim", "{file}"]

    # Select specific css elements on document
    config.set(
        "hints.selectors",
        {
            "focus": ["frame"],
            "pdf": ['[href*=".pdf"]'],
            "reddit": [".button-plain"],
            **c.hints.selectors,
        },
    )

    c.hints.selectors["all"].append(".button-plain")

    # Override mode in domains
    config.set("input.mode_override", "passthrough", "*://www.figma.com/*")

    # Allow websites to lock your mouse pointer.
    config.set("content.mouse_lock", True, "https://game.play-cs.com")

    # User agent for Whatsapp
    config.set(
        "content.headers.user_agent",
        "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
        "https://web.whatsapp.com/",
    )

    # User agent for Google accounts
    config.set(
        "content.headers.user_agent",
        "Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0",
        "https://accounts.google.com/*",
    )

    # Load images automatically in web pages.
    config.set("content.images", True, "chrome-devtools://*")
    config.set("content.images", True, "devtools://*")

    # Enable JavaScript.
    config.set("content.javascript.enabled", True, "chrome-devtools://*")
    config.set("content.javascript.enabled", True, "devtools://*")
    config.set("content.javascript.enabled", True, "chrome://*/*")
    config.set("content.javascript.enabled", True, "qute://*/*")

    # Allow locally loaded documents to access remote URLs.
    config.set(
        "content.local_content_can_access_remote_urls",
        True,
        f"file://{config.configdir}/userscripts/*",
    )

    # Allow locally loaded documents to access other local URLs.
    config.set(
        "content.local_content_can_access_file_urls",
        False,
        f"file://{config.configdir}/userscripts/*",
    )

    # Chromium flags
    config.set(
        "qt.args",
        [
            "ignore-gpu-blocklist",
            "enable-gpu-rasterization",
            "enable-accelerated-video-decode",
        ],
    )
