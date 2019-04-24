module Concur.React.Router.Types where

import Concur.React.Router.FFI (toString)
import Data.Maybe (Maybe(..))
import Data.Show (class Show)

data UnImplemented
instance showUnImplemented :: Show UnImplemented where
  show = toString

-- | The data passed to a route handler
type RouteHandlerArgs =
  { match :: Match
  , location :: Location
  , history :: UnImplemented
  -- ^ TODO: Wrap history package
  }

type Match =
  { params :: UnImplemented
    -- ^ TODO: Implement params
  , isExact :: Boolean
  , path :: String
  , url :: String
  }

type Location =
  { key :: String
  , pathname :: String
  , search :: String
  , hash :: String
  , state :: UnImplemented
    -- ^ TODO: Implement state
  }

data RoutePattern
  = CatchAll
  | Exact String
  | InExact String

type Redirect = 
  { to :: String
    -- ^ TODO: Support for state
  , push :: Boolean
  }

getPathFrom :: RoutePattern -> Maybe String
getPathFrom CatchAll = Nothing
getPathFrom (Exact s) = Just s
getPathFrom (InExact s) = Just s

isExact :: RoutePattern -> Boolean
isExact (Exact _) = true
isExact _ = false
