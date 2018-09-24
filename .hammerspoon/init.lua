hs.loadSpoon("WinWin")

hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

local hyper = {"shift", "option", "command"}
myCurrentAppName = ""

-- Maximize window when specify application started.
local maximizeApps = {
  "/Applications/iTerm.app",
  "/Applications/Google Chrome.app",
}

local windowCreateFilter = hs.window.filter.new():setDefaultFilter()
windowCreateFilter:subscribe(
  hs.window.filter.windowCreated,
  function (win, ttl, last)
    for index, value in ipairs(maximizeApps) do
      if win:application():path() == value then
        win:maximize()
        return true
      end
    end
end)

-- app shortcuts
local key2App = {
  e = {"Emacs"},
  f = {"Google Chrome"},
  t = {"iTerm"},
  a = {"Finder", true},
  q = {"企业微信", true},
}

for button, appConf in pairs(key2App) do
  local appName = appConf[1]
  local canHide = appConf[2] or nil

  hs.hotkey.bind(hyper, button, function()
    focused = hs.window.focusedWindow():application();
    if focused:name() == appName then
      if canHide then
        focused:hide()
        -- only hidable apps use Chinese
        English()
      end
    else
      gotoApp(appName)
    end
    -- hack for weird behaviour
    if appName == "Emacs" then
      English()
    end
  end)
end

hs.hotkey.bind(hyper, "space", function()
    if hs.window.focusedWindow():application():name() == "Emacs" then
      gotoApp("Google Chrome")
      English()
    else
      gotoApp("Emacs")
      English()
    end
end)

function gotoApp(appName)
  myCurrentAppName = appName
  if appName == "Google Chrome" then
    hs.execute("open -a 'Google Chrome' --args '--remote-debugging-port=9222'")
  else
    hs.application.launchOrFocus(appName)
  end
end

-- app default input methods
function Chinese()
  hs.keycodes.currentSourceID("com.googlecode.rimeime.inputmethod.Squirrel.Rime")
end

function English()
  hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end

function set_app_input_method(app_name, set_input_method_function, event)
  event = event or hs.window.filter.windowFocused

  hs.window.filter.new(app_name):subscribe(event, function()
      set_input_method_function()
  end)
end

set_app_input_method('Hammerspoon', English, hs.window.filter.windowCreated)
set_app_input_method('Spotlight', English, hs.window.filter.windowCreated)
set_app_input_method('Alfred', English, hs.window.filter.windowCreated)
set_app_input_method('微信', Chinese)
set_app_input_method('企业微信', Chinese)
set_app_input_method('Google Chrome', English)
set_app_input_method('iTerm2', English)
set_app_input_method('Emacs', English)

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
  -- Move cursor to center of application when application activated.
  -- Then don't need move cursor between screens.
  if (eventType == hs.application.watcher.activated) then
    -- Just adjust cursor postion if app open by user keyboard.
    if appName == myCurrentAppName then
      spoon.WinWin:centerCursor()
      myCurrentAppName = ""
    end
  end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- vimium-like hints for windows
hs.hotkey.bind(hyper, "s", function()
  hs.hints.windowHints()
end)
