import XMonad
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.WithAll
import XMonad.Actions.MouseResize
import XMonad.Layout.WindowArranger

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doCenterFloat)
import XMonad.Hooks.WindowSwallowing

    -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.Hacks (windowedFullscreenFixEventHook, javaHack, trayerAboveXmobarEventHook, trayAbovePanelEventHook, trayerPaddingXmobarEventHook, trayPaddingXmobarEventHook, trayPaddingEventHook)
import XMonad.Util.NamedActions
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.Cursor (setDefaultCursor)

myModMask :: KeyMask
myModMask = mod1Mask

myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String 
myBrowser = "firefox"

myLauncher :: String
myLauncher = "dmenu_run"

myNormColor :: String       
myNormColor   = "#959cbd" 

myFocusColor :: String
myFocusColor  =  "#3d59a1"

myBorderWidth :: Dimension
myBorderWidth = 2

myFont :: String
myFont = "xft:Ubuntu:bold:size=60"

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Hooks
myStartupHook :: X ()
myStartupHook = do 
     setDefaultCursor xC_left_ptr

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet) 
myManageHook = composeAll [
     title =? "Mozilla Firefox"     --> doShift ( myWorkspaces !! 2 ),
     isFullscreen --> doFullFloat]

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#9aedfe"
                 , inactiveColor       = "#9aedfe"
                 , activeBorderColor   = "#9aedfe"
                 , inactiveBorderColor = "#9aedfe"
                 , activeTextColor     = "#9aedfe"
                 , inactiveTextColor   = "#9aedfe"
                 }

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

spirals  = renamed [Replace "spirals"]
           $ limitWindows 9
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing 8
           $ spiral (6/7)

monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ Full

-- The layout hook
myLayoutHook = avoidStruts
               $ mouseResize
               $ windowArrange
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout = withBorder myBorderWidth spirals
                                              ||| monocle

myKeys conf@(XConfig {XMonad.modMask = mod1Mask}) = M.fromList $
    [ 
        ((mod1Mask, xK_t),    spawn myTerminal),
        ((mod1Mask, xK_p),    spawn myLauncher),
        ((mod1Mask, xK_b),    spawn myBrowser),
        ((mod1Mask, xK_q),         kill),
        ((mod1Mask .|. shiftMask, xK_a), killAll),
        ((mod1Mask, xK_space),    sendMessage NextLayout),
        ((mod1Mask, xK_j),        windows W.focusUp),
        ((mod1Mask, xK_k),        windows W.focusDown),
        ((mod1Mask .|. shiftMask, xK_m), windows W.swapMaster),
        ((mod1Mask .|. shiftMask, xK_j), windows W.swapDown),
		((mod1Mask .|. shiftMask, xK_k), windows W.swapUp),

        ((mod1Mask, xK_l),        sendMessage Expand),
        ((mod1Mask, xK_h),        sendMessage Shrink),

        ((mod1Mask, xK_plus), 	increaseLimit),
        ((mod1Mask, xK_minus), decreaseLimit),

        ((mod1Mask .|. shiftMask, xK_q), spawn "prgep xmonad | xargs kill"),
        ((mod1Mask .|. shiftMask, xK_r), spawn "xmonad --restart")
    ]

    ++

    [
        -- Move workspace or send window to any workspaces
        ((m .|. mod1Mask, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

main :: IO()
main = xmonad $ ewmhFullscreen . ewmh . docks $ def  {
    manageHook         = myManageHook <+> manageDocks 
    , handleEventHook    = windowedFullscreenFixEventHook <> swallowEventHook (className =? "Alacritty" <||> className =? "alacritty") (return True) -- <> trayerPaddingXmobarEventHook
    , modMask            = myModMask
    , terminal           = myTerminal
    , startupHook        = myStartupHook
    , layoutHook         = myLayoutHook
    , workspaces         = myWorkspaces
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormColor
    , focusedBorderColor = myFocusColor
    , keys = myKeys
}
