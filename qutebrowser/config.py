config.load_autoconfig()
config.source('blueper.py')

# NOTE: See https://github.com/qutebrowser/qutebrowser/issues/5656
c.qt.workarounds.remove_service_workers = True

## Aliases for commands. The keys of the given dictionary are the
## aliases, while the values are the commands they map to.
## Type: Dict
c.aliases = {
    "w": "session-save",
    "q": "close",
    "qa": "quit",
    "wq": "quit --save",
    "wqa": "quit --save",
}

## Time interval (in milliseconds) between auto-saves of
## config/cookies/etc.
## Type: Int
# c.auto_save.interval = 15000

## Always restore open sites when qutebrowser is reopened.
## Type: Bool
c.auto_save.session = True

## Backend to use to display websites. qutebrowser supports two different
## web rendering engines / backends, QtWebKit and QtWebEngine. QtWebKit
## was discontinued by the Qt project with Qt 5.6, but picked up as a
## well maintained fork: https://github.com/annulen/webkit/wiki -
## qutebrowser only supports the fork. QtWebEngine is Qt's official
## successor to QtWebKit. It's slightly more resource hungry than
## QtWebKit and has a couple of missing features in qutebrowser, but is
## generally the preferred choice.
## Type: String
## Valid values:
##   - webengine: Use QtWebEngine (based on Chromium).
##   - webkit: Use QtWebKit (based on WebKit, similar to Safari).
# c.backend = 'webengine'

## This setting can be used to map keys to other keys. When the key used
## as dictionary-key is pressed, the binding for the key used as
## dictionary-value is invoked instead. This is useful for global
## remappings of keys, for example to map Ctrl-[ to Escape. Note that
## when a key is bound (via `bindings.default` or `bindings.commands`),
## the mapping is ignored.
## Type: Dict
c.bindings.key_mappings = {
    "<Ctrl-[>": "<Escape>",
    "<Ctrl-6>": "<Ctrl-^>",
    "<Ctrl-M>": "<Return>",
    "<Ctrl-J>": "<Return>",
    "<Ctrl-I>": "<Tab>",
    "<Shift-Return>": "<Return>",
    "<Enter>": "<Return>",
    "<Shift-Enter>": "<Return>",
    "<Ctrl-Enter>": "<Ctrl-Return>",
}

## Number of commands to save in the command history. 0: no history / -1:
## unlimited
## Type: Int
# c.completion.cmd_history_max_items = 100

## Delay (in milliseconds) before updating completions after typing a
## character.
## Type: Int
# c.completion.delay = 0

## Height (in pixels or as percentage of the window) of the completion.
## Type: PercOrInt
# c.completion.height = '50%'

## Minimum amount of characters needed to update completions.
## Type: Int
# c.completion.min_chars = 1

## Which categories to show (in which order) in the :open completion.
## Type: FlagList
## Valid values:
##   - searchengines
##   - quickmarks
##   - bookmarks
##   - history
# c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history']

## Move on to the next part when there's only one possible completion
## left.
## Type: Bool
# c.completion.quick = True

## Padding (in pixels) of the scrollbar handle in the completion window.
## Type: Int
# c.completion.scrollbar.padding = 2

## Width (in pixels) of the scrollbar in the completion window.
## Type: Int
# c.completion.scrollbar.width = 12

## When to show the autocompletion window.
## Type: String
## Valid values:
##   - always: Whenever a completion is available.
##   - auto: Whenever a completion is requested.
##   - never: Never.
# c.completion.show = 'always'

## Shrink the completion to be smaller than the configured size if there
## are no scrollbars.
## Type: Bool
# c.completion.shrink = False

## Format of timestamps (e.g. for the history completion). See
## https://sqlite.org/lang_datefunc.html for allowed substitutions.
## Type: String
# c.completion.timestamp_format = '%Y-%m-%d'

## Execute the best-matching command on a partial match.
## Type: Bool
c.completion.use_best_match = False

## A list of patterns which should not be shown in the history. This only
## affects the completion. Matching URLs are still saved in the history
## (and visible on the qute://history page), but hidden in the
## completion. Changing this setting will cause the completion history to
## be regenerated on the next start, which will take a short while.
## Type: List of UrlPattern
# c.completion.web_history.exclude = []

## Number of URLs to show in the web history. 0: no history / -1:
## unlimited
## Type: Int
# c.completion.web_history.max_items = -1

## Require a confirmation before quitting the application.
## Type: ConfirmQuit
## Valid values:
##   - always: Always show a confirmation.
##   - multiple-tabs: Show a confirmation if multiple tabs are opened.
##   - downloads: Show a confirmation if downloads are running
##   - never: Never show a confirmation.
# c.confirm_quit = ['never']

## Automatically start playing `<video>` elements. Note: On Qt < 5.11,
## this option needs a restart and does not support URL patterns.
## Type: Bool
c.content.autoplay = False

## Enable support for the HTML 5 web application cache feature. An
## application cache acts like an HTTP cache in some sense. For documents
## that use the application cache via JavaScript, the loader engine will
## first ask the application cache for the contents, before hitting the
## network.
## Type: Bool
# c.content.cache.appcache = True

## Maximum number of pages to hold in the global memory page cache. The
## page cache allows for a nicer user experience when navigating forth or
## back to pages in the forward/back history, by pausing and resuming up
## to _n_ pages. For more information about the feature, please refer to:
## http://webkit.org/blog/427/webkit-page-cache-i-the-basics/
## Type: Int
# c.content.cache.maximum_pages = 0

## Size (in bytes) of the HTTP network cache. Null to use the default
## value. With QtWebEngine, the maximum supported value is 2147483647 (~2
## GB).
## Type: Int
# c.content.cache.size = None

## Allow websites to read canvas elements. Note this is needed for some
## websites to work properly.
## Type: Bool
# c.content.canvas_reading = True

## Which cookies to accept. With QtWebEngine, this setting also controls
## other features with tracking capabilities similar to those of cookies;
## including IndexedDB, DOM storage, filesystem API, service workers, and
## AppCache. Note that with QtWebKit, only `all` and `never` are
## supported as per-domain values. Setting `no-3rdparty` or `no-
## unknown-3rdparty` per-domain on QtWebKit will have the same effect as
## `all`. If this setting is used with URL patterns, the pattern gets
## applied to the origin/first party URL of the page making the request,
## not the request URL.
## Type: String
## Valid values:
##   - all: Accept all cookies.
##   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
##   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
##   - never: Don't accept cookies at all.
# c.content.cookies.accept = 'all'

## Store cookies. Note this option needs a restart with QtWebEngine on Qt
## < 5.9.
## Type: Bool
# c.content.cookies.store = True

## Default encoding to use for websites. The encoding must be a string
## describing an encoding such as _utf-8_, _iso-8859-1_, etc.
## Type: String
# c.content.default_encoding = 'iso-8859-1'

## Allow websites to share screen content. On Qt < 5.10, a dialog box is
## always displayed, even if this is set to "true".
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.desktop_capture = 'ask'

## Try to pre-fetch DNS entries to speed up browsing.
## Type: Bool
# c.content.dns_prefetch = True

## Expand each subframe to its contents. This will flatten all the frames
## to become one scrollable page.
## Type: Bool
# c.content.frame_flattening = False

## Set fullscreen notification overlay timeout in milliseconds. If set to
## 0, no overlay will be displayed.
## Type: Int
# c.content.fullscreen.overlay_timeout = 3000

## Limit fullscreen to the browser window (does not expand to fill the
## screen).
## Type: Bool
# c.content.fullscreen.window = False

## Allow websites to request geolocations.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.geolocation = 'ask'

## Value to send in the `Accept-Language` header. Note that the value
## read from JavaScript is always the global value.
## Type: String
# c.content.headers.accept_language = 'en-US,en;q=0.9'

## Custom headers for qutebrowser HTTP requests.
## Type: Dict
# c.content.headers.custom = {}

## Value to send in the `DNT` header. When this is set to true,
## qutebrowser asks websites to not track your identity. If set to null,
## the DNT header is not sent at all.
## Type: Bool
# c.content.headers.do_not_track = True

## When to send the Referer header. The Referer header tells websites
## from which website you were coming from when visiting them. No restart
## is needed with QtWebKit.
## Type: String
## Valid values:
##   - always: Always send the Referer.
##   - never: Never send the Referer. This is not recommended, as some sites may break.
##   - same-domain: Only send the Referer for the same domain. This will still protect your privacy, but shouldn't break any sites. With QtWebEngine, the referer will still be sent for other domains, but with stripped path information.
# c.content.headers.referer = 'same-domain'

## User agent to send.  The following placeholders are defined:  *
## `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
## The underlying WebKit version (set to a fixed value   with
## QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
## QtWebEngine. * `{qt_version}`: The underlying Qt version. *
## `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
## QtWebEngine. * `{upstream_browser_version}`: The corresponding
## Safari/Chrome version. * `{qutebrowser_version}`: The currently
## running qutebrowser version.  The default value is equal to the
## unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
## read from JavaScript is always the global value. With QtWebEngine
## between 5.12 and 5.14 (inclusive), changing the value exposed to
## JavaScript requires a restart.
## Type: FormatString
# c.content.headers.user_agent = 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {qt_key}/{qt_version} {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}'

## Enable host blocking.
## Type: Bool
# c.content.host_blocking.enabled = True

## List of URLs of lists which contain hosts to block.  The file can be
## in one of the following formats:  - An `/etc/hosts`-like file - One
## host per line - A zip-file of any of the above, with either only one
## file, or a file   named `hosts` (with any extension).  It's also
## possible to add a local file or directory via a `file://` URL. In case
## of a directory, all files in the directory are read as adblock lists.
## The file `~/.config/qutebrowser/blocked-hosts` is always read if it
## exists.
## Type: List of Url
# c.content.host_blocking.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts']

## A list of patterns that should always be loaded, despite being ad-
## blocked. Note this whitelists blocked hosts, not first-party URLs. As
## an example, if `example.org` loads an ad from `ads.example.org`, the
## whitelisted host should be `ads.example.org`. If you want to disable
## the adblocker on a given page, use the `content.host_blocking.enabled`
## setting with a URL pattern instead. Local domains are always exempt
## from hostblocking.
## Type: List of UrlPattern
# c.content.host_blocking.whitelist = []

## Enable hyperlink auditing (`<a ping>`).
## Type: Bool
# c.content.hyperlink_auditing = False

## Load images automatically in web pages.
## Type: Bool
c.content.images = True

## Show javascript alerts.
## Type: Bool
# c.content.javascript.alert = True

## Allow JavaScript to read from or write to the clipboard. With
## QtWebEngine, writing the clipboard as response to a user interaction
## is always allowed.
## Type: Bool
# c.content.javascript.can_access_clipboard = False

## Allow JavaScript to close tabs.
## Type: Bool
# c.content.javascript.can_close_tabs = False

## Allow JavaScript to open new tabs without user interaction.
## Type: Bool
# c.content.javascript.can_open_tabs_automatically = False

## Enable JavaScript.
## Type: Bool
c.content.javascript.enabled = True

## Log levels to use for JavaScript console logging messages. When a
## JavaScript message with the level given in the dictionary key is
## logged, the corresponding dictionary value selects the qutebrowser
## logger to use. On QtWebKit, the "unknown" setting is always used. The
## following levels are valid: `none`, `debug`, `info`, `warning`,
## `error`.
## Type: Dict
# c.content.javascript.log = {'unknown': 'debug', 'info': 'debug', 'warning': 'debug', 'error': 'debug'}

## Use the standard JavaScript modal dialog for `alert()` and
## `confirm()`.
## Type: Bool
# c.content.javascript.modal_dialog = False

## Show javascript prompts.
## Type: Bool
# c.content.javascript.prompt = True

## Allow locally loaded documents to access other local URLs.
## Type: Bool
# c.content.local_content_can_access_file_urls = True

## Allow locally loaded documents to access remote URLs.
## Type: Bool
# c.content.local_content_can_access_remote_urls = False

## Enable support for HTML 5 local storage and Web SQL.
## Type: Bool
# c.content.local_storage = True

## Allow websites to record audio/video.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.media_capture = 'ask'

## Allow websites to lock your mouse pointer.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.mouse_lock = 'ask'

## Automatically mute tabs. Note that if the `:tab-mute` command is used,
## the mute status for the affected tab is now controlled manually, and
## this setting doesn't have any effect.
## Type: Bool
# c.content.mute = False

## Netrc-file for HTTP authentication. If unset, `~/.netrc` is used.
## Type: File
# c.content.netrc_file = None

## Allow websites to show notifications.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.notifications = 'ask'

## Allow pdf.js to view PDF files in the browser. Note that the files can
## still be downloaded by clicking the download button in the pdf.js
## viewer.
## Type: Bool
c.content.pdfjs = True

## Allow websites to request persistent storage quota via
## `navigator.webkitPersistentStorage.requestQuota`.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.persistent_storage = 'ask'

## Enable plugins in Web pages.
## Type: Bool
# c.content.plugins = False

## Draw the background color and images also when the page is printed.
## Type: Bool
# c.content.print_element_backgrounds = True

## Open new windows in private browsing mode which does not record
## visited pages.
## Type: Bool
# c.content.private_browsing = False

## Proxy to use. In addition to the listed values, you can use a
## `socks://...` or `http://...` URL. Note that with QtWebEngine, it will
## take a couple of seconds until the change is applied, if this value is
## changed at runtime.
## Type: Proxy
## Valid values:
##   - system: Use the system wide proxy.
##   - none: Don't use any proxy
# c.content.proxy = 'system'

## Send DNS requests over the configured proxy.
## Type: Bool
# c.content.proxy_dns_requests = True

## Allow websites to register protocol handlers via
## `navigator.registerProtocolHandler`.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.register_protocol_handler = 'ask'

## Enable quirks (such as faked user agent headers) needed to get
## specific sites to work properly.
## Type: Bool
# c.content.site_specific_quirks = True

## Validate SSL handshakes.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.ssl_strict = 'ask'

## How navigation requests to URLs with unknown schemes are handled.
## Type: String
## Valid values:
##   - disallow: Disallows all navigation requests to URLs with unknown schemes.
##   - allow-from-user-interaction: Allows navigation requests to URLs with unknown schemes that are issued from user-interaction (like a mouse-click), whereas other navigation requests (for example from JavaScript) are suppressed.
##   - allow-all: Allows all navigation requests to URLs with unknown schemes.
# c.content.unknown_url_scheme_policy = 'allow-from-user-interaction'

## List of user stylesheet filenames to use.
## Type: List of File, or File
# c.content.user_stylesheets = []

## Enable WebGL.
## Type: Bool
# c.content.webgl = True

## Which interfaces to expose via WebRTC. On Qt 5.10, this option doesn't
## work because of a Qt bug.
## Type: String
## Valid values:
##   - all-interfaces: WebRTC has the right to enumerate all interfaces and bind them to discover public interfaces.
##   - default-public-and-private-interfaces: WebRTC should only use the default route used by http. This also exposes the associated default private address. Default route is the route chosen by the OS on a multi-homed endpoint.
##   - default-public-interface-only: WebRTC should only use the default route used by http. This doesn't expose any local addresses.
##   - disable-non-proxied-udp: WebRTC should only use TCP to contact peers or servers unless the proxy server supports UDP. This doesn't expose any local addresses either.
# c.content.webrtc_ip_handling_policy = 'all-interfaces'

## Monitor load requests for cross-site scripting attempts. Suspicious
## scripts will be blocked and reported in the devtools JavaScript
## console. Note that bypasses for the XSS auditor are widely known and
## it can be abused for cross-site info leaks in some scenarios, see:
## https://www.chromium.org/developers/design-documents/xss-auditor
## Type: Bool
# c.content.xss_auditing = False

## Directory to save downloads to. If unset, a sensible OS-specific
## default is used.
## Type: Directory
# c.downloads.location.directory = None

## Prompt the user for the download location. If set to false,
## `downloads.location.directory` will be used.
## Type: Bool
# c.downloads.location.prompt = True

## Remember the last used download directory.
## Type: Bool
# c.downloads.location.remember = True

## What to display in the download filename input.
## Type: String
## Valid values:
##   - path: Show only the download path.
##   - filename: Show only download filename.
##   - both: Show download path and filename.
# c.downloads.location.suggestion = 'path'

## Default program used to open downloads. If null, the default internal
## handler is used. Any `{}` in the string will be expanded to the
## filename, else the filename will be appended.
## Type: String
# c.downloads.open_dispatcher = None

## Where to show the downloaded files.
## Type: VerticalPosition
## Valid values:
##   - top
##   - bottom
# c.downloads.position = 'top'

## Duration (in milliseconds) to wait before removing finished downloads.
## If set to -1, downloads are never removed.
## Type: Int
# c.downloads.remove_finished = -1

## Editor (and arguments) to use for the `edit-text` command. The
## following placeholders are defined:  * `{file}`: Filename of the file
## to be edited. * `{line}`: Line in which the caret is found in the
## text. * `{column}`: Column in which the caret is found in the text. *
## `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
## Same as `{column}`, but starting from index 0.
## Type: ShellCommand
c.editor.command = ["kitty", "vim", "{file}", "-c", "normal {line}G{column}|"]

## Encoding to use for the editor.
## Type: Encoding
c.editor.encoding = "utf-8"

## Font used in the completion categories.
## Type: Font
# c.fonts.completion.category = 'bold default_size default_family'

## Font used in the completion widget.
## Type: Font
# c.fonts.completion.entry = 'default_size default_family'

## Font used for the context menu. If set to null, the Qt default is
## used.
## Type: Font
# c.fonts.contextmenu = None

## Font used for the debugging console.
## Type: Font
# c.fonts.debug_console = 'default_size default_family'

## Default font families to use. Whenever "default_family" is used in a
## font setting, it's replaced with the fonts listed here. If set to an
## empty value, a system-specific monospace default is used.
## Type: List of Font, or Font
# c.fonts.default_family = []

## Default font size to use. Whenever "default_size" is used in a font
## setting, it's replaced with the size listed here. Valid values are
## either a float value with a "pt" suffix, or an integer value with a
## "px" suffix.
## Type: String
# c.fonts.default_size = '10pt'

## Font used for the downloadbar.
## Type: Font
# c.fonts.downloads = 'default_size default_family'

## Font used for the hints.
## Type: Font
# c.fonts.hints = 'bold default_size default_family'

## Font used in the keyhint widget.
## Type: Font
# c.fonts.keyhint = 'default_size default_family'

## Font used for error messages.
## Type: Font
# c.fonts.messages.error = 'default_size default_family'

## Font used for info messages.
## Type: Font
# c.fonts.messages.info = 'default_size default_family'

## Font used for warning messages.
## Type: Font
# c.fonts.messages.warning = 'default_size default_family'

## Font used for prompts.
## Type: Font
# c.fonts.prompts = 'default_size sans-serif'

## Font used in the statusbar.
## Type: Font
# c.fonts.statusbar = 'default_size default_family'

## Font used for selected tabs.
## Type: Font
# c.fonts.tabs.selected = 'default_size default_family'

## Font used for unselected tabs.
## Type: Font
# c.fonts.tabs.unselected = 'default_size default_family'

## Font family for cursive fonts.
## Type: FontFamily
# c.fonts.web.family.cursive = ''

## Font family for fantasy fonts.
## Type: FontFamily
# c.fonts.web.family.fantasy = ''

## Font family for fixed fonts.
## Type: FontFamily
# c.fonts.web.family.fixed = ''

## Font family for sans-serif fonts.
## Type: FontFamily
# c.fonts.web.family.sans_serif = ''

## Font family for serif fonts.
## Type: FontFamily
# c.fonts.web.family.serif = ''

## Font family for standard fonts.
## Type: FontFamily
# c.fonts.web.family.standard = ''

## Default font size (in pixels) for regular text.
## Type: Int
# c.fonts.web.size.default = 16

## Default font size (in pixels) for fixed-pitch text.
## Type: Int
# c.fonts.web.size.default_fixed = 13

## Hard minimum font size (in pixels).
## Type: Int
# c.fonts.web.size.minimum = 0

## Minimum logical font size (in pixels) that is applied when zooming
## out.
## Type: Int
# c.fonts.web.size.minimum_logical = 6

## When a hint can be automatically followed without pressing Enter.
## Type: String
## Valid values:
##   - always: Auto-follow whenever there is only a single hint on a page.
##   - unique-match: Auto-follow whenever there is a unique non-empty match in either the hint string (word mode) or filter (number mode).
##   - full-match: Follow the hint when the user typed the whole hint (letter, word or number mode) or the element's text (only in number mode).
##   - never: The user will always need to press Enter to follow a hint.
# c.hints.auto_follow = 'unique-match'

## Duration (in milliseconds) to ignore normal-mode key bindings after a
## successful auto-follow.
## Type: Int
# c.hints.auto_follow_timeout = 0

## CSS border value for hints.
## Type: String
# c.hints.border = '1px solid #E3BE23'

## Characters used for hint strings.
## Type: UniqueCharString
# c.hints.chars = 'asdfghjkl'

## Dictionary file to be used by the word hints.
## Type: File
# c.hints.dictionary = '/usr/share/dict/words'

## Which implementation to use to find elements to hint.
## Type: String
## Valid values:
##   - javascript: Better but slower
##   - python: Slightly worse but faster
# c.hints.find_implementation = 'python'

## Hide unmatched hints in rapid mode.
## Type: Bool
# c.hints.hide_unmatched_rapid_hints = True

## Leave hint mode when starting a new page load.
## Type: Bool
# c.hints.leave_on_load = True

## Minimum number of characters used for hint strings.
## Type: Int
# c.hints.min_chars = 1

## Mode to use for hints.
## Type: String
## Valid values:
##   - number: Use numeric hints. (In this mode you can also type letters from the hinted element to filter and reduce the number of elements that are hinted.)
##   - letter: Use the characters in the `hints.chars` setting.
##   - word: Use hints words based on the html elements and the extra words.
# c.hints.mode = 'letter'

## Comma-separated list of regular expressions to use for 'next' links.
## Type: List of Regex
# c.hints.next_regexes = ['\\bnext\\b', '\\bmore\\b', '\\bnewer\\b', '\\b[>→≫]\\b', '\\b(>>|»)\\b', '\\bcontinue\\b']

## Padding (in pixels) for hints.
## Type: Padding
# c.hints.padding = {'top': 0, 'bottom': 0, 'left': 3, 'right': 3}

## Comma-separated list of regular expressions to use for 'prev' links.
## Type: List of Regex
# c.hints.prev_regexes = ['\\bprev(ious)?\\b', '\\bback\\b', '\\bolder\\b', '\\b[<←≪]\\b', '\\b(<<|«)\\b']

## Rounding radius (in pixels) for the edges of hints.
## Type: Int
# c.hints.radius = 3

## Scatter hint key chains (like Vimium) or not (like dwb). Ignored for
## number hints.
## Type: Bool
# c.hints.scatter = True

## CSS selectors used to determine which elements on a page should have
## hints.
## Type: Dict
# c.hints.selectors = {'all': ['a', 'area', 'textarea', 'select', 'input:not([type="hidden"])', 'button', 'frame', 'iframe', 'img', 'link', 'summary', '[onclick]', '[onmousedown]', '[role="link"]', '[role="option"]', '[role="button"]', '[ng-click]', '[ngClick]', '[data-ng-click]', '[x-ng-click]', '[tabindex]'], 'links': ['a[href]', 'area[href]', 'link[href]', '[role="link"][href]'], 'images': ['img'], 'media': ['audio', 'img', 'video'], 'url': ['[src]', '[href]'], 'inputs': ['input[type="text"]', 'input[type="date"]', 'input[type="datetime-local"]', 'input[type="email"]', 'input[type="month"]', 'input[type="number"]', 'input[type="password"]', 'input[type="search"]', 'input[type="tel"]', 'input[type="time"]', 'input[type="url"]', 'input[type="week"]', 'input:not([type])', 'textarea']}

## Make characters in hint strings uppercase.
## Type: Bool
# c.hints.uppercase = False

## Maximum time (in minutes) between two history items for them to be
## considered being from the same browsing session. Items with less time
## between them are grouped when being displayed in `:history`. Use -1 to
## disable separation.
## Type: Int
# c.history_gap_interval = 30

## Allow Escape to quit the crash reporter.
## Type: Bool
# c.input.escape_quits_reporter = True

## Which unbound keys to forward to the webview in normal mode.
## Type: String
## Valid values:
##   - all: Forward all unbound keys.
##   - auto: Forward unbound non-alphanumeric keys.
##   - none: Don't forward any keys.
# c.input.forward_unbound_keys = 'auto'

## Enter insert mode if an editable element is clicked.
## Type: Bool
# c.input.insert_mode.auto_enter = True

## Leave insert mode if a non-editable element is clicked.
## Type: Bool
# c.input.insert_mode.auto_leave = True

## Automatically enter insert mode if an editable element is focused
## after loading the page.
## Type: Bool
# c.input.insert_mode.auto_load = False

## Leave insert mode when starting a new page load. Patterns may be
## unreliable on this setting, and they may match the url you are
## navigating to, or the URL you are navigating from.
## Type: Bool
# c.input.insert_mode.leave_on_load = True

## Switch to insert mode when clicking flash and other plugins.
## Type: Bool
# c.input.insert_mode.plugins = False

## Include hyperlinks in the keyboard focus chain when tabbing.
## Type: Bool
# c.input.links_included_in_focus_chain = True

## Enable back and forward buttons on the mouse.
## Type: Bool
# c.input.mouse.back_forward_buttons = True

## Enable Opera-like mouse rocker gestures. This disables the context
## menu.
## Type: Bool
# c.input.mouse.rocker_gestures = False

## Timeout (in milliseconds) for partially typed key bindings. If the
## current input forms only partial matches, the keystring will be
## cleared after this time.
## Type: Int
# c.input.partial_timeout = 5000

## Enable spatial navigation. Spatial navigation consists in the ability
## to navigate between focusable elements in a Web page, such as
## hyperlinks and form controls, by using Left, Right, Up and Down arrow
## keys. For example, if the user presses the Right key, heuristics
## determine whether there is an element he might be trying to reach
## towards the right and which element he probably wants.
## Type: Bool
# c.input.spatial_navigation = False

## Keychains that shouldn't be shown in the keyhint dialog. Globs are
## supported, so `;*` will blacklist all keychains starting with `;`. Use
## `*` to disable keyhints.
## Type: List of String
# c.keyhint.blacklist = []

## Time (in milliseconds) from pressing a key to seeing the keyhint
## dialog.
## Type: Int
# c.keyhint.delay = 500

## Rounding radius (in pixels) for the edges of the keyhint dialog.
## Type: Int
# c.keyhint.radius = 6

## Level for console (stdout/stderr) logs. Ignored if the `--loglevel` or
## `--debug` CLI flags are used.
## Type: LogLevel
## Valid values:
##   - vdebug
##   - debug
##   - info
##   - warning
##   - error
##   - critical
# c.logging.level.console = 'info'

## Level for in-memory logs.
## Type: LogLevel
## Valid values:
##   - vdebug
##   - debug
##   - info
##   - warning
##   - error
##   - critical
# c.logging.level.ram = 'debug'

## Duration (in milliseconds) to show messages in the statusbar for. Set
## to 0 to never clear messages.
## Type: Int
# c.messages.timeout = 2000

## How to open links in an existing instance if a new one is launched.
## This happens when e.g. opening a link from a terminal. See
## `new_instance_open_target_window` to customize in which window the
## link is opened in.
## Type: String
## Valid values:
##   - tab: Open a new tab in the existing window and activate the window.
##   - tab-bg: Open a new background tab in the existing window and activate the window.
##   - tab-silent: Open a new tab in the existing window without activating the window.
##   - tab-bg-silent: Open a new background tab in the existing window without activating the window.
##   - window: Open in a new window.
c.new_instance_open_target = "tab"

## Which window to choose when opening links as new tabs. When
## `new_instance_open_target` is set to `window`, this is ignored.
## Type: String
## Valid values:
##   - first-opened: Open new tabs in the first (oldest) opened window.
##   - last-opened: Open new tabs in the last (newest) opened window.
##   - last-focused: Open new tabs in the most recently focused window.
##   - last-visible: Open new tabs in the most recently visible window.
c.new_instance_open_target_window = "last-focused"

## Show a filebrowser in download prompts.
## Type: Bool
# c.prompt.filebrowser = True

## Rounding radius (in pixels) for the edges of prompts.
## Type: Int
# c.prompt.radius = 8

## Additional arguments to pass to Qt, without leading `--`. With
## QtWebEngine, some Chromium arguments (see
## https://peter.sh/experiments/chromium-command-line-switches/ for a
## list) will work.
## Type: List of String
# c.qt.args = []

## Force a Qt platform to use. This sets the `QT_QPA_PLATFORM`
## environment variable and is useful to force using the XCB plugin when
## running QtWebEngine on Wayland.
## Type: String
# c.qt.force_platform = None

## Force a Qt platformtheme to use. This sets the `QT_QPA_PLATFORMTHEME`
## environment variable which controls dialogs like the filepicker. By
## default, Qt determines the platform theme based on the desktop
## environment.
## Type: String
# c.qt.force_platformtheme = None

## Force software rendering for QtWebEngine. This is needed for
## QtWebEngine to work with Nouveau drivers and can be useful in other
## scenarios related to graphic issues.
## Type: String
## Valid values:
##   - software-opengl: Tell LibGL to use a software implementation of GL (`LIBGL_ALWAYS_SOFTWARE` / `QT_XCB_FORCE_SOFTWARE_OPENGL`)
##   - qt-quick: Tell Qt Quick to use a software renderer instead of OpenGL. (`QT_QUICK_BACKEND=software`)
##   - chromium: Tell Chromium to disable GPU support and use Skia software rendering instead. (`--disable-gpu`)
##   - none: Don't force software rendering.
# c.qt.force_software_rendering = 'none'

## Turn on Qt HighDPI scaling. This is equivalent to setting
## QT_AUTO_SCREEN_SCALE_FACTOR=1 or QT_ENABLE_HIGHDPI_SCALING=1 (Qt >=
## 5.14) in the environment. It's off by default as it can cause issues
## with some bitmap fonts. As an alternative to this, it's possible to
## set font sizes and the `zoom.default` setting.
## Type: Bool
# c.qt.highdpi = False

## When to use Chromium's low-end device mode. This improves the RAM
## usage of renderer processes, at the expense of performance.
## Type: String
## Valid values:
##   - always: Always use low-end device mode.
##   - auto: Decide automatically (uses low-end mode with < 1 GB available RAM).
##   - never: Never use low-end device mode.
# c.qt.low_end_device_mode = 'auto'

## Which Chromium process model to use. Alternative process models use
## less resources, but decrease security and robustness. See the
## following pages for more details:    -
## https://www.chromium.org/developers/design-documents/process-models
## - https://doc.qt.io/qt-5/qtwebengine-features.html#process-models
## Type: String
## Valid values:
##   - process-per-site-instance: Pages from separate sites are put into separate processes and separate visits to the same site are also isolated.
##   - process-per-site: Pages from separate sites are put into separate processes. Unlike Process per Site Instance, all visits to the same site will share an OS process. The benefit of this model is reduced memory consumption, because more web pages will share processes. The drawbacks include reduced security, robustness, and responsiveness.
##   - single-process: Run all tabs in a single process. This should be used for debugging purposes only, and it disables `:open --private`.
# c.qt.process_model = 'process-per-site-instance'

## When/how to show the scrollbar.
## Type: String
## Valid values:
##   - always: Always show the scrollbar.
##   - never: Never show the scrollbar.
##   - when-searching: Show the scrollbar when searching for text in the webpage. With the QtWebKit backend, this is equal to `never`.
##   - overlay: Show an overlay scrollbar. With Qt < 5.11 or on macOS, this is unavailable and equal to `when-searching`; with the QtWebKit backend, this is equal to `never`. Enabling/disabling overlay scrollbars requires a restart.
# c.scrolling.bar = 'overlay'

## Enable smooth scrolling for web pages. Note smooth scrolling does not
## work with the `:scroll-px` command.
## Type: Bool
# c.scrolling.smooth = False

## When to find text on a page case-insensitively.
## Type: IgnoreCase
## Valid values:
##   - always: Search case-insensitively.
##   - never: Search case-sensitively.
##   - smart: Search case-sensitively if there are capital characters.
c.search.ignore_case = "smart"

## Find text on a page incrementally, renewing the search for each typed
## character.
## Type: Bool
c.search.incremental = True

## Wrap around at the top and bottom of the page when advancing through
## text matches using `:search-next` and `:search-prev`.
## Type: Bool
c.search.wrap = True

## Name of the session to save by default. If this is set to null, the
## session which was last loaded is saved.
## Type: SessionName
# c.session.default_name = None

## Load a restored tab as soon as it takes focus.
## Type: Bool
c.session.lazy_restore = False

## Languages to use for spell checking. You can check for available
## languages and install dictionaries using scripts/dictcli.py. Run the
## script with -h/--help for instructions.
## Type: List of String
## Valid values:
##   - af-ZA: Afrikaans (South Africa)
##   - bg-BG: Bulgarian (Bulgaria)
##   - ca-ES: Catalan (Spain)
##   - cs-CZ: Czech (Czech Republic)
##   - da-DK: Danish (Denmark)
##   - de-DE: German (Germany)
##   - el-GR: Greek (Greece)
##   - en-AU: English (Australia)
##   - en-CA: English (Canada)
##   - en-GB: English (United Kingdom)
##   - en-US: English (United States)
##   - es-ES: Spanish (Spain)
##   - et-EE: Estonian (Estonia)
##   - fa-IR: Farsi (Iran)
##   - fo-FO: Faroese (Faroe Islands)
##   - fr-FR: French (France)
##   - he-IL: Hebrew (Israel)
##   - hi-IN: Hindi (India)
##   - hr-HR: Croatian (Croatia)
##   - hu-HU: Hungarian (Hungary)
##   - id-ID: Indonesian (Indonesia)
##   - it-IT: Italian (Italy)
##   - ko: Korean
##   - lt-LT: Lithuanian (Lithuania)
##   - lv-LV: Latvian (Latvia)
##   - nb-NO: Norwegian (Norway)
##   - nl-NL: Dutch (Netherlands)
##   - pl-PL: Polish (Poland)
##   - pt-BR: Portuguese (Brazil)
##   - pt-PT: Portuguese (Portugal)
##   - ro-RO: Romanian (Romania)
##   - ru-RU: Russian (Russia)
##   - sh: Serbo-Croatian
##   - sk-SK: Slovak (Slovakia)
##   - sl-SI: Slovenian (Slovenia)
##   - sq: Albanian
##   - sr: Serbian
##   - sv-SE: Swedish (Sweden)
##   - ta-IN: Tamil (India)
##   - tg-TG: Tajik (Tajikistan)
##   - tr-TR: Turkish (Turkey)
##   - uk-UA: Ukrainian (Ukraine)
##   - vi-VN: Vietnamese (Viet Nam)
# c.spellcheck.languages = []

## Padding (in pixels) for the statusbar.
## Type: Padding
# c.statusbar.padding = {'top': 1, 'bottom': 1, 'left': 0, 'right': 0}

## Position of the status bar.
## Type: VerticalPosition
## Valid values:
##   - top
##   - bottom
# c.statusbar.position = 'bottom'

## When to show the statusbar.
## Type: String
## Valid values:
##   - always: Always show the statusbar.
##   - never: Always hide the statusbar.
##   - in-mode: Show the statusbar when in modes other than normal mode.
c.statusbar.show = "always"

## List of widgets displayed in the statusbar.
## Type: List of String
## Valid values:
##   - url: Current page URL.
##   - scroll: Percentage of the current page position like `10%`.
##   - scroll_raw: Raw percentage of the current page position like `10`.
##   - history: Display an arrow when possible to go back/forward in history.
##   - tabs: Current active tab, e.g. `2`.
##   - keypress: Display pressed keys when composing a vi command.
##   - progress: Progress bar for the current page loading.
# c.statusbar.widgets = ['keypress', 'url', 'scroll', 'history', 'tabs', 'progress']

## Open new tabs (middleclick/ctrl+click) in the background.
## Type: Bool
# c.tabs.background = False

## Mouse button with which to close tabs.
## Type: String
## Valid values:
##   - right: Close tabs on right-click.
##   - middle: Close tabs on middle-click.
##   - none: Don't close tabs using the mouse.
c.tabs.close_mouse_button = "middle"

## How to behave when the close mouse button is pressed on the tab bar.
## Type: String
## Valid values:
##   - new-tab: Open a new tab.
##   - close-current: Close the current tab.
##   - close-last: Close the last tab.
##   - ignore: Don't do anything.
c.tabs.close_mouse_button_on_bar = "new-tab"

## Scaling factor for favicons in the tab bar. The tab size is unchanged,
## so big favicons also require extra `tabs.padding`.
## Type: Float
# c.tabs.favicons.scale = 1.0

## When to show favicons in the tab bar.
## Type: String
## Valid values:
##   - always: Always show favicons.
##   - never: Always hide favicons.
##   - pinned: Show favicons only on pinned tabs.
# c.tabs.favicons.show = 'always'

## Maximum stack size to remember for tab switches (-1 for no maximum).
## Type: Int
# c.tabs.focus_stack_size = 10

## Padding (in pixels) for tab indicators.
## Type: Padding
# c.tabs.indicator.padding = {'top': 2, 'bottom': 2, 'left': 0, 'right': 4}

## Width (in pixels) of the progress indicator (0 to disable).
## Type: Int
# c.tabs.indicator.width = 3

## How to behave when the last tab is closed.
## Type: String
## Valid values:
##   - ignore: Don't do anything.
##   - blank: Load a blank page.
##   - startpage: Load the start page.
##   - default-page: Load the default page.
##   - close: Close the window.
c.tabs.last_close = "ignore"

## Maximum width (in pixels) of tabs (-1 for no maximum). This setting
## only applies when tabs are horizontal. This setting does not apply to
## pinned tabs, unless `tabs.pinned.shrink` is False. This setting may
## not apply properly if max_width is smaller than the minimum size of
## tab contents, or smaller than tabs.min_width.
## Type: Int
# c.tabs.max_width = -1

## Minimum width (in pixels) of tabs (-1 for the default minimum size
## behavior). This setting only applies when tabs are horizontal. This
## setting does not apply to pinned tabs, unless `tabs.pinned.shrink` is
## False.
## Type: Int
# c.tabs.min_width = -1

## When switching tabs, what input mode is applied.
## Type: String
## Valid values:
##   - persist: Retain the current mode.
##   - restore: Restore previously saved mode.
##   - normal: Always revert to normal mode.
# c.tabs.mode_on_change = 'normal'

## Switch between tabs using the mouse wheel.
## Type: Bool
# c.tabs.mousewheel_switching = True

## Position of new tabs opened from another tab. See
## `tabs.new_position.stacking` for controlling stacking behavior.
## Type: NewTabPosition
## Valid values:
##   - prev: Before the current tab.
##   - next: After the current tab.
##   - first: At the beginning.
##   - last: At the end.
c.tabs.new_position.related = "next"

## Stack related tabs on top of each other when opened consecutively.
## Only applies for `next` and `prev` values of
## `tabs.new_position.related` and `tabs.new_position.unrelated`.
## Type: Bool
c.tabs.new_position.stacking = True

## Position of new tabs which are not opened from another tab. See
## `tabs.new_position.stacking` for controlling stacking behavior.
## Type: NewTabPosition
## Valid values:
##   - prev: Before the current tab.
##   - next: After the current tab.
##   - first: At the beginning.
##   - last: At the end.
c.tabs.new_position.unrelated = "last"

## Padding (in pixels) around text for tabs.
## Type: Padding
# c.tabs.padding = {'top': 0, 'bottom': 0, 'left': 5, 'right': 5}

## Force pinned tabs to stay at fixed URL.
## Type: Bool
# c.tabs.pinned.frozen = True

## Shrink pinned tabs down to their contents.
## Type: Bool
# c.tabs.pinned.shrink = True

## Position of the tab bar.
## Type: Position
## Valid values:
##   - top
##   - bottom
##   - left
##   - right
c.tabs.position = "top"

## Which tab to select when the focused tab is removed.
## Type: SelectOnRemove
## Valid values:
##   - prev: Select the tab which came before the closed one (left in horizontal, above in vertical).
##   - next: Select the tab which came after the closed one (right in horizontal, below in vertical).
##   - last-used: Select the previously selected tab.
c.tabs.select_on_remove = "next"

## When to show the tab bar.
## Type: String
## Valid values:
##   - always: Always show the tab bar.
##   - never: Always hide the tab bar.
##   - multiple: Hide the tab bar if only one tab is open.
##   - switching: Show the tab bar when switching tabs.
c.tabs.show = "always"

## Duration (in milliseconds) to show the tab bar before hiding it when
## tabs.show is set to 'switching'.
## Type: Int
# c.tabs.show_switching_delay = 800

## Open a new window for every tab.
## Type: Bool
# c.tabs.tabs_are_windows = False

## Alignment of the text inside of tabs.
## Type: TextAlignment
## Valid values:
##   - left
##   - right
##   - center
# c.tabs.title.alignment = 'left'

## Format to use for the tab title. The following placeholders are
## defined:  * `{perc}`: Percentage as a string like `[10%]`. *
## `{perc_raw}`: Raw percentage, e.g. `10`. * `{current_title}`: Title of
## the current web page. * `{title_sep}`: The string ` - ` if a title is
## set, empty otherwise. * `{index}`: Index of this tab. * `{id}`:
## Internal tab ID of this tab. * `{scroll_pos}`: Page scroll position. *
## `{host}`: Host of the current web page. * `{backend}`: Either
## ''webkit'' or ''webengine'' * `{private}`: Indicates when private mode
## is enabled. * `{current_url}`: URL of the current web page. *
## `{protocol}`: Protocol (http/https/...) of the current web page. *
## `{audio}`: Indicator for audio/mute status.
## Type: FormatString
# c.tabs.title.format = '{audio}{index}: {current_title}'

## Format to use for the tab title for pinned tabs. The same placeholders
## like for `tabs.title.format` are defined.
## Type: FormatString
# c.tabs.title.format_pinned = '{index}'

## Show tooltips on tabs. Note this setting only affects windows opened
## after it has been set.
## Type: Bool
# c.tabs.tooltips = True

## Number of close tab actions to remember, per window (-1 for no
## maximum).
## Type: Int
# c.tabs.undo_stack_size = 100

## Width (in pixels or as percentage of the window) of the tab bar if
## it's vertical.
## Type: PercOrInt
# c.tabs.width = '20%'

## Wrap when changing tabs.
## Type: Bool
# c.tabs.wrap = True

## What search to start when something else than a URL is entered.
## Type: String
## Valid values:
##   - naive: Use simple/naive check.
##   - dns: Use DNS requests (might be slow!).
##   - never: Never search automatically.
##   - schemeless: Always search automatically unless URL explicitly contains a scheme.
# c.url.auto_search = 'naive'

## Page to open if :open -t/-b/-w is used without URL. Use `about:blank`
## for a blank page.
## Type: FuzzyUrl
c.url.default_page = "about:blank"

## URL segments where `:navigate increment/decrement` will search for a
## number.
## Type: FlagList
## Valid values:
##   - host
##   - port
##   - path
##   - query
##   - anchor
# c.url.incdec_segments = ['path', 'query']

## Open base URL of the searchengine if a searchengine shortcut is
## invoked without parameters.
## Type: Bool
# c.url.open_base_url = False

## Search engines which can be used via the address bar.  Maps a search
## engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
## placeholder. The placeholder will be replaced by the search term, use
## `{{` and `}}` for literal `{`/`}` braces.  The following further
## placeholds are defined to configure how special characters in the
## search terms are replaced by safe characters (called 'quoting'):  *
## `{}` and `{semiquoted}` quote everything except slashes; this is the
## most   sensible choice for almost all search engines (for the search
## term   `slash/and&amp` this placeholder expands to `slash/and%26amp`).
## * `{quoted}` quotes all characters (for `slash/and&amp` this
## placeholder   expands to `slash%2Fand%26amp`). * `{unquoted}` quotes
## nothing (for `slash/and&amp` this placeholder   expands to
## `slash/and&amp`).  The search engine named `DEFAULT` is used when
## `url.auto_search` is turned on and something else than a URL was
## entered to be opened. Other search engines can be used by prepending
## the search engine name to the search term, e.g. `:open google
## qutebrowser`.
## Type: Dict
# c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}'}

## Page(s) to open at the start.
## Type: List of FuzzyUrl, or FuzzyUrl
# c.url.start_pages = ['https://start.duckduckgo.com']

## URL parameters to strip with `:yank url`.
## Type: List of String
# c.url.yank_ignored_parameters = ['ref', 'utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content']

## Hide the window decoration.  This setting requires a restart on
## Wayland.
## Type: Bool
# c.window.hide_decoration = False

## Format to use for the window title. The same placeholders like for
## `tabs.title.format` are defined.
## Type: FormatString
# c.window.title_format = '{perc}{current_title}{title_sep}qutebrowser'

## Default zoom level.
## Type: Perc
c.zoom.default = "100%"

## Available zoom levels.
## Type: List of Perc
c.zoom.levels = [
    "25%",
    "33%",
    "50%",
    "67%",
    "75%",
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

## Number of zoom increments to divide the mouse wheel movements to.
## Type: Int
# c.zoom.mouse_divider = 512

## Apply the zoom factor on a frame only to the text or to all content.
## Type: Bool
# c.zoom.text_only = False

## Default bindings
default_bindings = {
    "normal": {
        "'": "mode-enter jump_mark",
        "+": "zoom-in",
        "-": "zoom-out",
        ".": "repeat-command",
        "/": "set-cmd-text /",
        ":": "set-cmd-text :",
        ";I": "hint images tab",
        ";O": "hint links fill :open -t -r {hint-url}",
        ";R": "hint --rapid links window",
        ";Y": "hint links yank-primary",
        ";b": "hint all tab-bg",
        ";d": "hint links download",
        ";f": "hint all tab-fg",
        ";h": "hint all hover",
        ";i": "hint images",
        ";o": "hint links fill :open {hint-url}",
        ";r": "hint --rapid links tab-bg",
        ";t": "hint inputs",
        ";y": "hint links yank",
        "<Alt-1>": "tab-focus 1",
        "<Alt-2>": "tab-focus 2",
        "<Alt-3>": "tab-focus 3",
        "<Alt-4>": "tab-focus 4",
        "<Alt-5>": "tab-focus 5",
        "<Alt-6>": "tab-focus 6",
        "<Alt-7>": "tab-focus 7",
        "<Alt-8>": "tab-focus 8",
        "<Alt-9>": "tab-focus -1",
        "<Alt-m>": "tab-mute",
        "<Ctrl-A>": "navigate increment",
        "<Ctrl-Alt-p>": "print",
        "<Ctrl-B>": "scroll-page 0 -1",
        "<Ctrl-D>": "scroll-page 0 0.5",
        "<Ctrl-F5>": "reload -f",
        "<Ctrl-F>": "scroll-page 0 1",
        "<Ctrl-N>": "open -w",
        "<Ctrl-PgDown>": "tab-next",
        "<Ctrl-PgUp>": "tab-prev",
        "<Ctrl-Q>": "quit",
        "<Ctrl-Return>": "selection-follow -t",
        "<Ctrl-Shift-N>": "open -p",
        "<Ctrl-Shift-T>": "undo",
        "<Ctrl-Shift-Tab>": "nop",
        "<Ctrl-Shift-W>": "close",
        "<Ctrl-T>": "open -t",
        "<Ctrl-Tab>": "tab-focus last",
        "<Ctrl-U>": "scroll-page 0 -0.5",
        "<Ctrl-V>": "mode-enter passthrough",
        "<Ctrl-W>": "tab-close",
        "<Ctrl-X>": "navigate decrement",
        "<Ctrl-^>": "tab-focus last",
        "<Ctrl-h>": "home",
        "<Ctrl-p>": "tab-pin",
        "<Ctrl-s>": "stop",
        "<Escape>": "clear-keychain ;; search ;; fullscreen --leave",
        "<F11>": "fullscreen",
        "<F5>": "reload",
        "<Return>": "selection-follow",
        "<back>": "back",
        "<forward>": "forward",
        "=": "zoom",
        "?": "set-cmd-text ?",
        "@": "macro-run",
        "B": "set-cmd-text -s :quickmark-load -t",
        "D": "tab-close -o",
        "F": "hint all tab",
        "G": "scroll-to-perc",
        "H": "back",
        "J": "tab-next",
        "K": "tab-prev",
        "L": "forward",
        "M": "bookmark-add",
        "N": "search-prev",
        "O": "set-cmd-text -s :open -t",
        "PP": "open -t -- {primary}",
        "Pp": "open -t -- {clipboard}",
        "R": "reload -f",
        "Sb": "open qute://bookmarks#bookmarks",
        "Sh": "open qute://history",
        "Sq": "open qute://bookmarks",
        "Ss": "open qute://settings",
        "T": "tab-focus",
        "V": "mode-enter caret ;; selection-toggle --line",
        "ZQ": "quit",
        "ZZ": "quit --save",
        "[[": "navigate prev",
        "]]": "navigate next",
        "`": "mode-enter set_mark",
        "ad": "download-cancel",
        "b": "set-cmd-text -s :quickmark-load",
        "cd": "download-clear",
        "co": "tab-only",
        "d": "tab-close",
        "f": "hint",
        "g$": "tab-focus -1",
        "g0": "tab-focus 1",
        "gB": "set-cmd-text -s :bookmark-load -t",
        "gC": "tab-clone",
        "gD": "tab-give",
        "gO": "set-cmd-text :open -t -r {url:pretty}",
        "gU": "navigate up -t",
        "g^": "tab-focus 1",
        "ga": "open -t",
        "gb": "set-cmd-text -s :bookmark-load",
        "gd": "download",
        "gf": "view-source",
        "gg": "scroll-to-perc 0",
        "gi": "hint inputs --first",
        "gK": "tab-move -",
        "gm": "tab-move",
        "go": "set-cmd-text :open {url:pretty}",
        "gJ": "tab-move +",
        "gt": "set-cmd-text -s :tab-select",
        "gu": "navigate up",
        "h": "scroll left",
        "i": "mode-enter insert",
        "j": "scroll down",
        "k": "scroll up",
        "l": "scroll right",
        "m": "quickmark-save",
        "n": "search-next",
        "o": "set-cmd-text -s :open",
        "pP": "open -- {primary}",
        "pp": "open -- {clipboard}",
        "q": "macro-record",
        "r": "reload",
        "sf": "save",
        "sk": "set-cmd-text -s :bind",
        "sl": "set-cmd-text -s :set -t",
        "ss": "set-cmd-text -s :set",
        "tCH": "config-cycle -p -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload",
        "tCh": "config-cycle -p -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload",
        "tCu": "config-cycle -p -u {url} content.cookies.accept all no-3rdparty never ;; reload",
        "tIH": "config-cycle -p -u *://*.{url:host}/* content.images ;; reload",
        "tIh": "config-cycle -p -u *://{url:host}/* content.images ;; reload",
        "tIu": "config-cycle -p -u {url} content.images ;; reload",
        "tPH": "config-cycle -p -u *://*.{url:host}/* content.plugins ;; reload",
        "tPh": "config-cycle -p -u *://{url:host}/* content.plugins ;; reload",
        "tPu": "config-cycle -p -u {url} content.plugins ;; reload",
        "tSH": "config-cycle -p -u *://*.{url:host}/* content.javascript.enabled ;; reload",
        "tSh": "config-cycle -p -u *://{url:host}/* content.javascript.enabled ;; reload",
        "tSu": "config-cycle -p -u {url} content.javascript.enabled ;; reload",
        "tcH": "config-cycle -p -t -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload",
        "tch": "config-cycle -p -t -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload",
        "tcu": "config-cycle -p -t -u {url} content.cookies.accept all no-3rdparty never ;; reload",
        "th": "back -t",
        "tiH": "config-cycle -p -t -u *://*.{url:host}/* content.images ;; reload",
        "tih": "config-cycle -p -t -u *://{url:host}/* content.images ;; reload",
        "tiu": "config-cycle -p -t -u {url} content.images ;; reload",
        "tl": "forward -t",
        "tpH": "config-cycle -p -t -u *://*.{url:host}/* content.plugins ;; reload",
        "tph": "config-cycle -p -t -u *://{url:host}/* content.plugins ;; reload",
        "tpu": "config-cycle -p -t -u {url} content.plugins ;; reload",
        "tsH": "config-cycle -p -t -u *://*.{url:host}/* content.javascript.enabled ;; reload",
        "tsh": "config-cycle -p -t -u *://{url:host}/* content.javascript.enabled ;; reload",
        "tsu": "config-cycle -p -t -u {url} content.javascript.enabled ;; reload",
        "u": "undo",
        "v": "mode-enter caret",
        "wB": "set-cmd-text -s :bookmark-load -w",
        "wIh": "devtools left",
        "wIj": "devtools bottom",
        "wIk": "devtools top",
        "wIl": "devtools right",
        "wIw": "devtools window",
        "wO": "set-cmd-text :open -w {url:pretty}",
        "wP": "open -w -- {primary}",
        "wb": "set-cmd-text -s :quickmark-load -w",
        "wf": "hint all window",
        "wh": "back -w",
        "wi": "devtools",
        "wl": "forward -w",
        "wo": "set-cmd-text -s :open -w",
        "wp": "open -w -- {clipboard}",
        "xO": "set-cmd-text :open -b -r {url:pretty}",
        "xo": "set-cmd-text -s :open -b",
        "yD": "yank domain -s",
        "yM": "yank inline [{title}]({url}) -s",
        "yP": "yank pretty-url -s",
        "yT": "yank title -s",
        "yY": "yank -s",
        "yd": "yank domain",
        "ym": "yank inline [{title}]({url})",
        "yp": "yank pretty-url",
        "yt": "yank title",
        "yy": "yank",
        "{{": "navigate prev -t",
        "}}": "navigate next -t",
    },
    "caret": {
        "$": "move-to-end-of-line",
        "0": "move-to-start-of-line",
        "<Ctrl-Space>": "selection-reverse",
        "<Escape>": "mode-leave",
        "<Return>": "yank selection",
        "<Space>": "selection-toggle",
        "G": "move-to-end-of-document",
        "H": "scroll left",
        "J": "scroll down",
        "K": "scroll up",
        "L": "scroll right",
        "V": "selection-toggle --line",
        "Y": "yank selection -s",
        "[": "move-to-start-of-prev-block",
        "]": "move-to-start-of-next-block",
        "b": "move-to-prev-word",
        "c": "mode-enter normal",
        "e": "move-to-end-of-word",
        "gg": "move-to-start-of-document",
        "h": "move-to-prev-char",
        "j": "move-to-next-line",
        "k": "move-to-prev-line",
        "l": "move-to-next-char",
        "o": "selection-reverse",
        "v": "selection-toggle",
        "w": "move-to-next-word",
        "y": "yank selection",
        "{": "move-to-end-of-prev-block",
        "}": "move-to-end-of-next-block",
    },
    "command": {
        "<Alt-B>": "rl-backward-word",
        "<Alt-Backspace>": "rl-backward-kill-word",
        "<Alt-D>": "rl-kill-word",
        "<Alt-F>": "rl-forward-word",
        "<Ctrl-?>": "rl-delete-char",
        "<Ctrl-A>": "rl-beginning-of-line",
        "<Ctrl-B>": "rl-backward-char",
        "<Ctrl-C>": "completion-item-yank",
        "<Ctrl-D>": "completion-item-del",
        "<Ctrl-E>": "rl-end-of-line",
        "<Ctrl-F>": "rl-forward-char",
        "<Ctrl-H>": "rl-backward-delete-char",
        "<Ctrl-K>": "rl-kill-line",
        "<Ctrl-N>": "command-history-next",
        "<Ctrl-P>": "command-history-prev",
        "<Ctrl-Return>": "command-accept --rapid",
        "<Ctrl-Shift-C>": "completion-item-yank --sel",
        "<Ctrl-Shift-Tab>": "completion-item-focus prev-category",
        "<Ctrl-Tab>": "completion-item-focus next-category",
        "<Ctrl-U>": "rl-unix-line-discard",
        "<Ctrl-W>": "rl-unix-word-rubout",
        "<Ctrl-Y>": "rl-yank",
        "<Down>": "completion-item-focus --history next",
        "<Escape>": "mode-leave",
        "<Return>": "command-accept",
        "<Shift-Delete>": "completion-item-del",
        "<Shift-Tab>": "completion-item-focus prev",
        "<Tab>": "completion-item-focus next",
        "<Up>": "completion-item-focus --history prev",
    },
    "hint": {
        "<Ctrl-B>": "hint all tab-bg",
        "<Ctrl-F>": "hint links",
        "<Ctrl-R>": "hint --rapid links tab-bg",
        "<Escape>": "mode-leave",
        "<Return>": "hint-follow",
    },
    "insert": {
        "<Ctrl-E>": "edit-text",
        "<Escape>": "mode-leave",
        "<Shift-Ins>": "insert-text -- {primary}",
    },
    "passthrough": {
        "<Shift-Escape>": "mode-leave",
    },
    "prompt": {
        "<Alt-B>": "rl-backward-word",
        "<Alt-Backspace>": "rl-backward-kill-word",
        "<Alt-D>": "rl-kill-word",
        "<Alt-F>": "rl-forward-word",
        "<Alt-Shift-Y>": "prompt-yank --sel",
        "<Alt-Y>": "prompt-yank",
        "<Ctrl-?>": "rl-delete-char",
        "<Ctrl-A>": "rl-beginning-of-line",
        "<Ctrl-B>": "rl-backward-char",
        "<Ctrl-E>": "rl-end-of-line",
        "<Ctrl-F>": "rl-forward-char",
        "<Ctrl-H>": "rl-backward-delete-char",
        "<Ctrl-K>": "rl-kill-line",
        "<Ctrl-P>": "prompt-open-download --pdfjs",
        "<Ctrl-U>": "rl-unix-line-discard",
        "<Ctrl-W>": "rl-unix-word-rubout",
        "<Ctrl-X>": "prompt-open-download",
        "<Ctrl-Y>": "rl-yank",
        "<Down>": "prompt-item-focus next",
        "<Escape>": "mode-leave",
        "<Return>": "prompt-accept",
        "<Shift-Tab>": "prompt-item-focus prev",
        "<Tab>": "prompt-item-focus next",
        "<Up>": "prompt-item-focus prev",
    },
    "register": {
        "<Escape>": "mode-leave",
    },
    "yesno": {
        "<Alt-Shift-Y>": "prompt-yank --sel",
        "<Alt-Y>": "prompt-yank",
        "<Escape>": "mode-leave",
        "<Return>": "prompt-accept",
        "N": "prompt-accept --save no",
        "Y": "prompt-accept --save yes",
        "n": "prompt-accept no",
        "y": "prompt-accept yes",
    },
}

password = 'qute-bitwarden -d "dmenu -p Bitwarden -l 50" -p "dmenu -p BitwardenPassword -l 0"'

leader = ","
custom_bindings = {
    "normal": {
        leader + "m": "tab-mute",
    },
    "command": {
        "<Ctrl-C>": "mode-leave",
    },
    "insert": {
        "<Ctrl-L><Ctrl-L>": f"spawn --userscript {password}",
        "<Ctrl-L><Ctrl-U>": f"spawn --userscript {password} --username-only",
        "<Ctrl-L><Ctrl-P>": f"spawn --userscript {password} --password-only",
    },
}

bindings = {**default_bindings, **custom_bindings}
for mode, binds in bindings.items():
    for key, val in binds.items():
        config.bind(key, val, mode=mode)
