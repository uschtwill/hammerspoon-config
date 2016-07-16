-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "j", function()
--   sizeup.send_window_left()
-- end)

-- === sizeup ===
--
-- SizeUp emulation for hammerspoon
--
-- To use, you can tweak the key bindings and the margins

local sizeup = { }

--------------
-- Bindings --
--------------

--- Split Screen Actions ---
-- Send Window Left
hs.hotkey.bind({"cmd","alt","ctrl"}, "j", function()
  sizeup.send_window_left()
end)
-- Send Window
hs.hotkey.bind({"cmd","alt","ctrl"}, "l", function()
  sizeup.send_window_right()
end)
-- Send Window Up
hs.hotkey.bind({"cmd","alt","ctrl"}, "i", function()
  sizeup.send_window_up()
end)
-- Send Window Down
hs.hotkey.bind({"cmd","alt","ctrl"}, "m", function()
  sizeup.send_window_down()
end)

--- Quarter Screen Actions ---
-- Send Window Upper Left
hs.hotkey.bind({"ctrl", "alt", "shift"}, "Left", function()
  sizeup.send_window_upper_left()
end)
-- Send Window Upper Right
hs.hotkey.bind({"ctrl","alt", "shift"}, "Up", function()
  sizeup.send_window_upper_right()
end)
-- Send Window Lower Left
hs.hotkey.bind({"ctrl", "alt", "shift"}, "Down", function()
  sizeup.send_window_lower_left()
end)
-- Send Window Lower Right
hs.hotkey.bind({"ctrl", "alt", "shift"}, "Right", function()
  sizeup.send_window_lower_right()
end)

--- Multiple Monitor Actions ---
-- Send Window Prev Monitor
-- hs.hotkey.bind({ "cmd", "alt","ctrl"}, "u", function()
--   sizeup.send_window_prev_monitor()
-- end)
-- Send Window Next Monitor
hs.hotkey.bind({ "cmd", "alt","ctrl"}, "u", function()
  sizeup.send_window_next_monitor()
end)

--- Spaces Actions ---

-- Apple no longer provides any reliable API access to spaces.
-- As such, this feature no longer works in SizeUp on Yosemite and
-- Hammerspoon currently has no solution that isn't a complete hack.
-- If you have any ideas, please visit the ticket

--- Snapback Action ---
hs.hotkey.bind({"ctrl","alt","cmd"}, "Z", function()
  sizeup.snapback()
end)
--- Other Actions ---
-- Make Window Full Screen
hs.hotkey.bind({"cmd","alt","ctrl"}, "k", function()
  sizeup.maximize()
end)
-- -- Send Window Center
-- hs.hotkey.bind({"cmd","alt","ctrl"}, "J", function()
--   sizeup.move_to_center_absolute({w=800, h=600})
--   -- sizeup.move_to_center_relative({w=0.75, h=0.75})
-- end)


-------------------
-- Configuration --
-------------------

-- Margins --
sizeup.screen_edge_margins = {
  top =    0, -- px
  left =   0,
  right =  0,
  bottom = 0
}
sizeup.partition_margins = {
  x = 0, -- px
  y = 0
}

-- Partitions --
sizeup.split_screen_partitions = {
  x = 0.5, -- %
  y = 0.5
}
sizeup.quarter_screen_partitions = {
  x = 0.5, -- %
  y = 0.5
}


----------------
-- Public API --
----------------

function sizeup.send_window_left()
  local s = sizeup.screen()
  local ssp = sizeup.split_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Left", {
    x = s.x,
    y = s.y,
    w = (s.w * ssp.x) - sizeup.gutter().x,
    h = s.h
  })
end

function sizeup.send_window_right()
  local s = sizeup.screen()
  local ssp = sizeup.split_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Right", {
    x = s.x + (s.w * ssp.x) + g.x,
    y = s.y,
    w = (s.w * (1 - ssp.x)) - g.x,
    h = s.h
  })
end

function sizeup.send_window_up()
  local s = sizeup.screen()
  local ssp = sizeup.split_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Up", {
    x = s.x,
    y = s.y,
    w = s.w,
    h = (s.h * ssp.y) - g.y
  })
end

function sizeup.send_window_down()
  local s = sizeup.screen()
  local ssp = sizeup.split_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Down", {
    x = s.x,
    y = s.y + (s.h * ssp.y) + g.y,
    w = s.w,
    h = (s.h * (1 - ssp.y)) - g.y
  })
end

function sizeup.send_window_upper_left()
  local s = sizeup.screen()
  local qsp = sizeup.quarter_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Upper Left", {
    x = s.x,
    y = s.y,
    w = (s.w * qsp.x) - g.x,
    h = (s.h * qsp.y) - g.y
  })
end

function sizeup.send_window_upper_right()
  local s = sizeup.screen()
  local qsp = sizeup.quarter_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Upper Right", {
    x = s.x + (s.w * qsp.x) + g.x,
    y = s.y,
    w = (s.w * (1 - qsp.x)) - g.x,
    h = (s.h * (qsp.y)) - g.y
  })
end

function sizeup.send_window_lower_left()
  local s = sizeup.screen()
  local qsp = sizeup.quarter_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Lower Left", {
    x = s.x,
    y = s.y + (s.h * qsp.y) + g.y,
    w = (s.w * qsp.x) - g.x,
    h = (s.h * (1 - qsp.y)) - g.y
  })
end

function sizeup.send_window_lower_right()
  local s = sizeup.screen()
  local qsp = sizeup.quarter_screen_partitions
  local g = sizeup.gutter()
  sizeup.set_frame("Lower Right", {
    x = s.x + (s.w * qsp.x) + g.x,
    y = s.y + (s.h * qsp.y) + g.y,
    w = (s.w * (1 - qsp.x)) - g.x,
    h = (s.h * (1 - qsp.y)) - g.y
  })
end

function sizeup.send_window_prev_monitor()
  hs.alert.show("Prev Monitor")
  local win = hs.window.focusedWindow()
  local nextScreen = win:screen():previous()
  win:moveToScreen(nextScreen)
end

function sizeup.send_window_next_monitor()
  hs.alert.show("Next Monitor")
  local win = hs.window.focusedWindow()
  local nextScreen = win:screen():next()
  win:moveToScreen(nextScreen)
end

-- snapback return the window to its last position. calling snapback twice returns the window to its original position.
-- snapback holds state for each window, and will remember previous state even when focus is changed to another window.
function sizeup.snapback()
  local win = sizeup.win()
  local id = win:id()
  local state = win:frame()
  local prev_state = sizeup.snapback_window_state[id]
  if prev_state then
    win:setFrame(prev_state)
  end
  sizeup.snapback_window_state[id] = state
end

function sizeup.maximize()
  sizeup.set_frame("Full Screen", sizeup.screen())
end

--- move_to_center_relative(size)
--- Method
--- Centers and resizes the window to the the fit on the given portion of the screen.
--- The argument is a size with each key being between 0.0 and 1.0.
--- Example: win:move_to_center_relative(w=0.5, h=0.5) -- window is now centered and is half the width and half the height of screen
function sizeup.move_to_center_relative(unit)
  local s = sizeup.screen()
  sizeup.set_frame("Center", {
    x = s.x + (s.w * ((1 - unit.w) / 2)),
    y = s.y + (s.h * ((1 - unit.h) / 2)),
    w = s.w * unit.w,
    h = s.h * unit.h
  })
end

--- move_to_center_absolute(size)
--- Method
--- Centers and resizes the window to the the fit on the given portion of the screen given in pixels.
--- Example: win:move_to_center_relative(w=800, h=600) -- window is now centered and is 800px wide and 600px high
function sizeup.move_to_center_absolute(unit)
  local s = sizeup.screen()
  sizeup.set_frame("Center", {
    x = (s.w - unit.w) / 2,
    y = (s.h - unit.h) / 2,
    w = unit.w,
    h = unit.h
  })
end


------------------
-- Internal API --
------------------

-- SizeUp uses no animations
hs.window.animation_duration = 0.0
-- Initialize Snapback state
sizeup.snapback_window_state = { }
-- return currently focused window
function sizeup.win()
  return hs.window.focusedWindow()
end
-- display title, save state and move win to unit
function sizeup.set_frame(title, unit)
  hs.alert.show(title)
  local win = sizeup.win()
  sizeup.snapback_window_state[win:id()] = win:frame()
  return win:setFrame(unit)
end
-- screen is the available rect inside the screen edge margins
function sizeup.screen()
  local screen = sizeup.win():screen():frame()
  local sem = sizeup.screen_edge_margins
  return {
    x = screen.x + sem.left,
    y = screen.y + sem.top,
    w = screen.w - (sem.left + sem.right),
    h = screen.h - (sem.top + sem.bottom)
  }
end
-- gutter is the adjustment required to accomidate partition
-- margins between windows
function sizeup.gutter()
  local pm = sizeup.partition_margins
  return {
    x = pm.x / 2,
    y = pm.y / 2
  }
end

--- hs.window:moveToScreen(screen)
--- Method
--- move window to the the given screen, keeping the relative proportion and position window to the original screen.
--- Example: win:moveToScreen(win:screen():next()) -- move window to next screen
function hs.window:moveToScreen(nextScreen)
  local currentFrame = self:frame()
  local screenFrame = self:screen():frame()
  local nextScreenFrame = nextScreen:frame()
  self:setFrame({
    x = ((((currentFrame.x - screenFrame.x) / screenFrame.w) * nextScreenFrame.w) + nextScreenFrame.x),
    y = ((((currentFrame.y - screenFrame.y) / screenFrame.h) * nextScreenFrame.h) + nextScreenFrame.y),
    h = ((currentFrame.h / screenFrame.h) * nextScreenFrame.h),
    w = ((currentFrame.w / screenFrame.w) * nextScreenFrame.w)
  })
end


-- RAMEN TIMER --

--Schedule a notification in 3 minutes.
function startTeaTimer()
  hs.timer.doAfter(4 * 60 + 1 * 30, function ()
    hs.notify.new({
        title="Take the tea bag out!",
        informativeText="Your tea is ready!"
    }):send()
  end)
  hs.alert(" Tea bag timer started! ")
end

--Bind timer to `hammerspoon://ramentime`:
hs.urlevent.bind("tea_timer", startTeaTimer)
-- END RAMEN TIMER --

-- DISPLAY FOCUS SWITCHING --

--One hotkey should just suffice for dual-display setups as it will naturally
--cycle through both.
--A second hotkey to reverse the direction of the focus-shift would be handy
--for setups with 3 or more displays.

--Bring focus to next display/screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function ()
  focusScreen(hs.window.focusedWindow():screen():next())
end)

--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end

-- Brings focus to the scren by setting focus on the front-most application in it.
-- Also move the mouse cursor to the center of the screen. This is because
-- Mission Control gestures & keyboard shortcuts are anchored, oddly, on where the
-- mouse is focused.
function focusScreen(screen)
  --Get windows within screen, ordered from front to back.
  --If no windows exist, bring focus to desktop. Otherwise, set focus on
  --front-most application window.
  local windows = hs.fnutils.filter(
      hs.window.orderedWindows(),
      hs.fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
  windowToFocus:focus()

  -- Move mouse to center of screen
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)

    -- hs.mouse.setRelativePosition(center, nextScreen)
    hs.mouse.setAbsolutePosition(center)
end

-- END DISPLAY FOCUS SWITCHING --


-- AUTOLOADING OF HAMMERSPOON CONFIG --
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
-- END AUTOLOADING OF HAMMERSPOON CONFIG --
