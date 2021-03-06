{-# LANGUAGE DeriveGeneric #-}

module Api.Types where

import Control.Monad.Reader (ReaderT)
import Data.Aeson (FromJSON, ToJSON)
import Data.Serialize
import qualified Data.Text as T
import GHC.Generics
import Servant
import  Servant.Elm

data ResultResp = ResultResp {
  status        :: !T.Text
  , description :: !T.Text
} deriving (Eq, Show, Generic)

data AttachForm = AttachForm {
  postId :: !Int
  , mediaId :: !Int
} deriving (Eq, Show, Generic)

instance ElmType ResultResp
instance FromJSON ResultResp
instance ToJSON ResultResp

instance FromJSON AttachForm
instance ToJSON AttachForm
