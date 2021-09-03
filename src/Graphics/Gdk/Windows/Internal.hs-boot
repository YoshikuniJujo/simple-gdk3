{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Graphics.Gdk.Windows.Internal where

import Control.DeepSeq
import Foreign.Ptr
import Foreign.Storable

newtype GdkWindow = GdkWindow (Ptr GdkWindow)

instance Show GdkWindow
instance Storable GdkWindow
instance NFData GdkWindow
