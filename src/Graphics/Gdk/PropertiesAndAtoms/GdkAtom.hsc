{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE PatternSynonyms, ViewPatterns #-}
{-# LANGUAGE GeneralizedNewtypeDeriving, DeriveGeneric #-}
{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Graphics.Gdk.PropertiesAndAtoms.GdkAtom (
	-- * GDK ATOM
	GdkAtom(..), pattern GdkNone, gdkAtomIntern, gdkAtomName ) where

import GHC.Generics
import Foreign.Ptr
import Foreign.Storable
import Foreign.C.String
import Control.DeepSeq
import Data.Int

#include <gdk/gdk.h>

newtype GdkAtom = GdkAtom (Ptr GdkAtom) deriving (Show, Generic, Storable)

instance NFData GdkAtom

pattern GdkNone :: GdkAtom
pattern GdkNone <- GdkAtom (ptrToIntPtr -> IntPtr #{const GDK_NONE}) where
	GdkNone = GdkAtom . intPtrToPtr $ IntPtr #{const GDK_NONE}

gdkAtomIntern :: String -> IO GdkAtom
gdkAtomIntern nm = withCString nm \cnm -> c_gdk_atom_intern cnm #{const FALSE}

foreign import ccall "gdk_atom_intern" c_gdk_atom_intern ::
	CString -> #{type gboolean} -> IO GdkAtom

gdkAtomName :: GdkAtom -> IO String
gdkAtomName a= do
	cnm <- c_gdk_atom_name a
	peekCString cnm <* c_g_free cnm

foreign import ccall "gdk_atom_name" c_gdk_atom_name :: GdkAtom -> IO CString

foreign import ccall "g_free" c_g_free :: Ptr a -> IO ()
