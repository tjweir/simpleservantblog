{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE TypeOperators     #-}

module Api.Projects where

import           Control.Monad.IO.Class (liftIO)
import           Data.Proxy
import qualified Data.Text              as T
import           GHC.Generics
import           Servant


import           Api.Projects.TacoShop  (NameType (..), makeBertosName)


data Project = Project {
  name     :: !T.Text
  , result :: !T.Text
} deriving (Eq, Show, Generic)

type ProjectApi = "tacoshop" :> "random" :> Capture "len" Int :> Get '[JSON] Project
-- "tacoshop" :> "hmm" :> Capture "len" Int :> Get '[JSON] Project
-- "tacoshop" :> "rnn" :> Capture "len" Int :> Get '[JSON] Project

projectHandlers :: Server ProjectApi
projectHandlers = bertosH

bertosH :: Int -> Handler Project
bertosH n = do
  value <- if n < 6
    then pure "bertos"
    else liftIO $ makeBertosName n
  pure $ Project (T.pack $ show RandomCharacter) value

projectApi :: Proxy ProjectApi
projectApi = Proxy
