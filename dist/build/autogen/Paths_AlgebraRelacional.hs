module Paths_AlgebraRelacional (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/lautaro/.cabal/bin"
libdir     = "/home/lautaro/.cabal/lib/x86_64-linux-ghc-7.10.3/AlgebraRelacional-0.1.0.0-HBRGOqnuiEfFfxPX81EzL5"
datadir    = "/home/lautaro/.cabal/share/x86_64-linux-ghc-7.10.3/AlgebraRelacional-0.1.0.0"
libexecdir = "/home/lautaro/.cabal/libexec"
sysconfdir = "/home/lautaro/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "AlgebraRelacional_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "AlgebraRelacional_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "AlgebraRelacional_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "AlgebraRelacional_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "AlgebraRelacional_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
