pcall(require, "luarocks.loader")

local gears = require("gears") -- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox") -- Widget and layout library
local beautiful = require("beautiful") -- Theme handling library
local naughty = require("naughty") -- Notification library
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/ludwiklejzer/.config/awesome/retrolight/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "wezterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

mymainmenu = awful.menu({
	items = {
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
		{ "open terminal", terminal },
	},
})

-- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget({
	format = '<span fgcolor="#AAAAAA">%m/%d</span>  %H:%M',
	widget = wibox.widget.textclock,
})

-- Create a memory widgtet
local mymemory = wibox.widget({
	widget = awful.widget.watch("bash -c \"free -h --giga | awk '/^Mem/ {print $7}'\"", 4, function(widget, stdout)
		widget:set_markup('<span fgcolor="#AAAAAA">MEM </span>' .. stdout)
	end),
})

local myupdates = wibox.widget({
	widget = awful.widget.watch('bash -c "checkupdates | wc -l"', 7200, function(widget, stdout)
		widget:set_markup('<span fgcolor="#AAAAAA">UPD </span>' .. stdout)
	end),
})

local mydiskusage = wibox.widget({
	widget = awful.widget.watch("bash -c \"df -h /dev/sda4 | awk 'FNR==2{print $5}'\"", 300, function(widget, stdout)
		widget:set_markup('<span fgcolor="#AAAAAA">HDD </span>' .. stdout)
	end),
})

local myweather = wibox.widget({
	widget = awful.widget.watch(
		"bash -c 'curl -s https://wttr.in/?format=\"%t\" || echo OFF'",
		3600,
		function(widget, stdout)
			widget:set_markup('<span fgcolor="#AAAAAA">WTH </span>' .. stdout)
		end
	),
})

local myredshift = wibox.widget({
	widget = awful.widget.watch(
		"bash -c '[ \"$(pidof redshift)\" ] && echo ON || echo OFF'",
		4,
		function(widget, stdout)
			widget:set_markup('<span fgcolor="#AAAAAA">RED </span>' .. stdout)
		end
	),
})

local mywifi = wibox.widget({
	-- widget = awful.widget.watch("bash -c \"echo 'JLOC'\"", 3600, function(widget, stdout)
	widget = awful.widget.watch(
		"bash -c \"nmcli -f GENERAL.CONNECTION dev show wlp2s0 | awk '{print $2}'\"",
		4,
		function(widget, stdout)
			widget:set_markup('<span fgcolor="#AAAAAA">NET </span>' .. stdout)
		end
	),
})

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "  I ", " II ", " III ", " IV ", " V " }, s, awful.layout.layouts[1])

	s.mywifi = awful.widget.watch(
		"bash -c \"nmcli -f GENERAL.STATE device show wlp2s0 | grep -Eo '[0-9]{1,3}'\"",
		5,
		function(widget, stdout)
			if tonumber(stdout) == 100 then
				widget:set_text("")
			else
				widget:set_text("Disconnected")
			end
		end
	)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create the wibox
	s.mywibox_top = awful.wibar({
		position = "top",
		screen = s,
		height = 25,
		width = "100%",
		bg = beautiful.wibox_bg_normal,
		fg = beautiful.wibox_fg_normal,
		border_width = 1,
		border_color = beautiful.wibox_border_normal,
	})
	-- s.mywibox_top.visible = false
	-- Add widgets to the wibox
	s.mywibox_top:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 15,
			s.mytaglist,
			s.mypromptbox,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			spacing = 20,
		},
		{
			spacing = 20,
			-- myweather,
			-- mydiskusage,
			-- myupdates,
			-- mymemory,
			-- myredshift,
			-- mywifi,
			layout = wibox.layout.fixed.horizontal,
			mytextclock,
			wibox.container.margin(wibox.widget.systray(), 5, 5, 5, 5),
		},
	})
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function()
		mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
	awful.key({ modkey }, "i", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "[", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "]", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Tab", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.global_bydirection("down")
	end, { description = "swap with bottom client", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.global_bydirection("up")
	end, { description = "swap with top client", group = "client" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.client.swap.global_bydirection("left")
	end, { description = "swap with left client", group = "client" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.client.swap.global_bydirection("right")
	end, { description = "swap with right client", group = "client" }),

	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, "m", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "m", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey }, "n", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Shift" }, "n", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	-- awful.key({ modkey, "Control" }, "b", function()
	-- 	awful.layout.inc(1)
	-- end, { description = "select next", group = "layout" }),
	-- awful.key({ modkey, "Shift" }, "space", function()
	-- 	awful.layout.inc(-1)
	-- end, { description = "select previous", group = "layout" }),

	-- Prompt
	awful.key({ modkey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	awful.key({ modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	awful.key({ modkey }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" }),

	-- Personal keybindings
	awful.key({ modkey }, "space", function()
		awful.spawn("rofi -show drun")
	end, { description = "volume up", group = "launcher" }),
	awful.key({ modkey, "Shift" }, "=", function()
		awful.spawn("pactl -- set-sink-volume 0 +5%")
	end, { description = "increase volume", group = "launcher" }),
	awful.key({ modkey, "Shift" }, "-", function()
		awful.spawn("pactl -- set-sink-volume 0 -5%")
	end, { description = "decrease volume", group = "launcher" }),
	awful.key({ modkey, "Control" }, "=", function()
		awful.spawn("xbacklight -inc 5")
	end, { description = "increase brightness", group = "launcher" }),
	awful.key({ modkey, "Control" }, "-", function()
		awful.spawn("xbacklight -dec 5")
	end, { description = "decrease brightness", group = "launcher" }),
	awful.key({ modkey, "Shift" }, "c", function()
		awful.spawn("rofi -show calc -modi calc -no-show-match -no-sort -terse")
	end, { description = "rofi calculator", group = "launcher" }),
	awful.key({ modkey, "Shift" }, "e", function()
		awful.spawn("rofi -modi emoji -show emoji")
	end, { description = "rofi emoji", group = "launcher" }),
	awful.key({ modkey }, "b", function()
		awful.spawn("$BROWSER")
	end, { description = "open browser", group = "launcher" })
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key({ modkey }, "s", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),

	awful.key({ modkey, "Control" }, "l", function(c)
		if c.floating then
			c:relative_move(0, 0, 10, 0)
		else
			awful.tag.incmwfact(0.060)
		end
	end),
	awful.key({ modkey, "Control" }, "h", function(c)
		if c.floating then
			c:relative_move(0, 0, -10, 0)
		else
			awful.tag.incmwfact(-0.060)
		end
	end),
	awful.key({ modkey, "Control" }, "k", function(c)
		if c.floating then
			c:relative_move(0, 0, 0, -10)
		else
			awful.client.incwfact(0.25)
		end
	end),
	awful.key({ modkey, "Control" }, "j", function(c)
		if c.floating then
			c:relative_move(0, 0, 0, 25)
		else
			awful.client.incwfact(-0.25)
		end
	end),

	awful.key({ modkey }, "Left", function(c)
		c:relative_move(-10, 0, 0, 0)
	end),
	awful.key({ modkey }, "Right", function(c)
		c:relative_move(10, 0, 0, 0)
	end),
	awful.key({ modkey }, "Up", function(c)
		c:relative_move(0, -10, 0, 0)
	end),
	awful.key({ modkey }, "Down", function(c)
		c:relative_move(0, 10, 0, 0)
	end),

	awful.key({ modkey }, "j", function()
		awful.client.focus.global_bydirection("down")
	end, { description = "focus down window", group = "client" }),
	awful.key({ modkey }, "k", function(c)
		awful.client.focus.global_bydirection("up")
	end, { description = "focus top window", group = "client" }),
	awful.key({ modkey }, "h", function(c)
		awful.client.focus.global_bydirection("left")
	end, { description = "focus top window", group = "client" }),
	awful.key({ modkey }, "l", function(c)
		awful.client.focus.global_bydirection("right")
	end, { description = "focus top window", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true },
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = true } },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
			{
				align = "center",
				widget = wibox.widget({
					markup = " オーサムウィンドウマネージャー",
					align = "center",
					valign = "center",
					widget = wibox.widget.textbox,
					font = "Nikkyou Sans 10",
				}),
			},
		},
		{
			layout = wibox.layout.flex.horizontal,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			awful.titlebar.widget.maximizedbutton(c),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
-- }}}
