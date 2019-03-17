module Concur.React.Router.Types where

import Foreign (Foreign)

-- | The data passed to a route handler

-- | The data passed to a route handler
type RouteHandlerArgs st =
  { match :: Match
  , location :: Location st
  , history :: Foreign
  -- ^ TODO: Wrap history package
  }

type Match =
  { params :: Foreign
  , isExact :: Boolean
  , path :: String
  , url :: String
  }

type Location st =
  { key :: String
  , pathname :: String
  , search :: String
  , hash :: String
  , state :: st
  }

data RoutePattern
  = Exact String
  | InExact String

getPathFrom :: RoutePattern -> String
getPathFrom (Exact s) = s
getPathFrom (InExact s) = s

isExact :: RoutePattern -> Boolean
isExact (Exact _) = true
isExact _ = false
