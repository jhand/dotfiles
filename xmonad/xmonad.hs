import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

import qualified Data.Map as M  
import XMonad.Actions.CycleWS
import XMonad.Layout.IndependentScreens
 
keysToAdd x = [((mod4Mask, xK_F4), kill)
     ,((mod4Mask, xK_Left), prevWS )
     ,((mod4Mask, xK_Right), nextWS )
     ,((mod4Mask, xK_d), spawn "firefox" ) 
     ,((mod4Mask, xK_f), spawn "thunar" ) 
     ,((mod4Mask .|. shiftMask, xK_f), spawn "pcmanfm" ) 
     , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
     , ((0, xK_Print), spawn "scrot")
     ,((mod4Mask, xK_s), spawn "medit" ) ]
   
newKeys x = M.union (keys defaultConfig x) (M.fromList (keysToAdd x)) -- to include new keys to existing keys  
   
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myTerminal = "urxvt"
myWorkspaces    = ["1:www","2:term","3:dev","4:IM","5","6","7","8","9"]

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
      , resource =? "Dialog" --> doFloat
    ]
 
main = do
    nScreens <-  countScreens
    spawn "sh ~/.xmonad/autostart.sh"
    xmproc <- spawnPipe "xmobar ~/.xmonad/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
			, ppHiddenNoWindows = xmobarColor "grey" ""
			, ppHidden = xmobarColor "red" ""
			, ppVisible =  xmobarColor "orange" "" . wrap "(" ")"
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
	, terminal = myTerminal
	, workspaces = myWorkspaces
        , focusFollowsMouse = myFocusFollowsMouse
	, keys = newKeys
	}
