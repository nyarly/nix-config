import XMonad
import qualified Data.Map as M
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops        (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.Focus
import XMonad.Layout
import XMonad.Layout.Reflect
import XMonad.Layout.Fullscreen
import XMonad.Layout.PerScreen
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.ToggleLayouts
import XMonad.Actions.WindowBringer
import XMonad.Hooks.DynamicProperty
import qualified XMonad.Actions.CycleWS as C
import qualified XMonad.StackSet as W

-- c.f. http://hackage.haskell.org/package/xmonad-contrib-0.13/docs/XMonad-Actions-CycleWS.html

-- import System.Taffybar.Support.PagerHints (pagerHints)

startup :: X ()
startup = do
  spawn "systemctl --user restart xmonad.target"
  spawn "xset 600 10"
  spawn "xss-lock -n dim-screen -- i3lock -i ~/Data/Wallpaper/rotsnakes-tile.png -t"
  spawn "tmux start-server"

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
workspacesWithKeys = zip myWorkspaces [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0]

myLayout = avoidStruts $ ifWider 1900 (toggle tall ||| full) (Mirror $ toggle tall ||| full)
  where
    basic = smartBorders $ fullscreenFocus $ Tall 1 (3 /100) (3/4)
    tall = named "Tall" $ basic
    wide = named "Wide" $ Mirror $ basic
    full = named "Full" $ noBorders Full
    toggle = toggleLayouts full

wMenuArgs = def {
  menuCommand = "rofi",
  menuArgs = ["-dmenu"]
}
myBringMenu = actionMenu wMenuArgs bringWindow
myActivateMenu = actionMenu wMenuArgs activateWindow

activateWindow w ws = W.shiftMaster (W.focusWindow w ws)

mainUp =   windows (W.focusDown   . W.swapUp)
mainDown = windows (W.focusUp     . W.swapDown)

manageZoomHook =
  composeAll $
    [ (className =? zoomClassName) <&&> shouldFloat <$> title --> doFloat,
      (className =? zoomClassName) <&&> shouldSink <$> title --> doSink
    ]
  where
    zoomClassName = "zoom"
    tileTitles = [ "Zoom - Free Account",
        "Zoom - Licensed Account",
        "Zoom",
        "Zoom Meeting"
      ]
    shouldFloat title = title `notElem` tileTitles
    shouldSink title = title `elem` tileTitles
    doSink = (ask >>= doF . W.sink) <+> doF W.swapDown

-- launching and killing programs
-- mod-Shift-Enter  Launch xterminal
-- mod-p            Launch dmenu
-- mod-Shift-p      Launch gmrun
-- mod-Shift-c      Close/kill the focused window
-- mod-Space        Rotate through the available layout algorithms
-- mod-Shift-Space  Reset the layouts on the current workSpace to default
-- mod-n            Resize/refresh viewed windows to the correct size
--
-- -- move focus up or down the window stack
-- mod-Tab        Move focus to the next window
-- mod-Shift-Tab  Move focus to the previous window
-- mod-j          Move focus to the next window
-- mod-k          Move focus to the previous window
-- mod-m          Move focus to the master window
--
-- -- modifying the window order
-- mod-Return   Swap the focused window and the master window
-- mod-Shift-j  Swap the focused window with the next window
-- mod-Shift-k  Swap the focused window with the previous window
--
-- -- resizing the master/slave ratio
-- mod-h  Shrink the master area
-- mod-l  Expand the master area
--
-- -- floating layer support
-- mod-t  Push window back into tiling; unfloat and re-tile it
--
-- -- increase or decrease number of windows in the master area
-- mod-comma  (mod-,)   Increment the number of windows in the master area
-- mod-period (mod-.)   Deincrement the number of windows in the master area
--
-- -- quit, or restart
-- mod-Shift-q  Quit xmonad
-- mod-q        Restart xmonad
--
-- -- Workspaces & screens
-- mod-[1..9]         Switch to workSpace N
-- mod-Shift-[1..9]   Move client to workspace N
-- mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3
-- mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3
--
-- -- Mouse bindings: default actions bound to mouse events
-- mod-button1  Set the window to floating mode and move by dragging
-- mod-button2  Raise the window to the top of the stack
-- mod-button3  Set the window to floating mode and resize by dragging
--
--

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList ([
       ((modm, xK_z), spawn "loginctl lock-session"),
       ((modm, xK_p), spawn "rofi -show run -modi 'run,window' -show-icons -matching fuzzy -sidebar-mode &"),
       ((modm, xK_a), spawn "~/bin/rofi-screenlayout &"),
       ((modm, xK_f), spawn "rofi-pass &"),
       ((modm, xK_grave), spawn "~/bin/rofi-scripts &"),
       ((modm, xK_r), spawn "env TERMINAL=alacritty EDITOR=nvim rofi -modi tasks:rofi-taskwarrior -show tasks &"),
       ((modm, xK_g), spawn "rofi -show window -modi 'run,window' -show-icons -matching fuzzy -sidebar-mode &"),
       ((modm .|. shiftMask, xK_j ), mainDown ),
       ((modm .|. shiftMask, xK_k ), mainUp )
     ]
     ++ [ ((modm, key),                    C.toggleOrView tag) | (tag, key)  <- workspacesWithKeys ]
     ++ [ ((modm .|. shiftMask, key), (windows . W.shift) tag) | (tag, key)  <- workspacesWithKeys ]
     )
newKeys x = myKeys x `M.union` keys def x

activateFocusHook :: FocusHook
activateFocusHook = composeOne [ new(className =? "zoom") -?> keepFocus , Just(switchWorkspace <> switchFocus) ]


newFocusHook :: FocusHook
-- new (className =? "Gmrun") -?> switchFocus
-- , focused (className =? "Gmrun") -?> keepFocus
newFocusHook = composeOne [ new(className =? "zoom") -?> keepFocus, Just(switchFocus) ]

myManageHook = (composeAll . concat $ [
    [manageZoomHook]
  , [className =? "pinentry" --> doFloat]
  , [className =? "Pinentry" --> doFloat]
  , [className =? c --> doShift (myWorkspaces !! 3) | c <- chatS ]
  , [className =? c --> doShift (myWorkspaces !! 9) | c <- zoomS ]
  ])
  where
  chatS = ["signal", "hexchat", "fractal"]
  zoomS = ["zoom"]

main = xmonad $
       setEwmhActivateHook (manageFocus activateFocusHook) $
       ewmh $
       docks $
       def { modMask = mod4Mask  -- super instead of alt (usually Windows key)
           , terminal = "alacritty"
           , startupHook = startup
           , layoutHook = myLayout
           , logHook = dynamicLogString defaultPP >>= xmonadPropLog
           , manageHook = myManageHook <+> manageHook def
           , handleEventHook = mconcat [ dynamicTitle manageZoomHook, docksEventHook, handleEventHook defaultConfig ]
           , workspaces = myWorkspaces
           , keys = newKeys
           , normalBorderColor  = "#aaaaaa"
           , focusedBorderColor = "#666699"
           }
