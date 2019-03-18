module Concur.React.Router where

import Concur.Core (Widget, wrapViewEvent)
import Concur.React (HTML, el, el')
import Concur.React.DOM (El1, El)
import Concur.React.Props as P
import Concur.React.Router.FFI (_browserRouter, _hashRouter, _link, _route, _switch, debugShow)
import Concur.React.Router.Types (RoutePattern, RouteHandlerArgs, getPathFrom, isExact)
import Control.Applicative (pure)
import Control.MultiAlternative (orr)
import Data.Maybe (Maybe(..))
import Data.Monoid ((<>))
import Effect.Uncurried (mkEffectFn1)
import Prelude (discard)
import React.DOM.Props as R


-- | A Router that uses HTML5 History API
-- | Use this whenever possible
withBrowserRouter :: El1
withBrowserRouter = el _browserRouter

-- | A Router that uses window.location.hash
-- | Use this only if HTML5 History API is not available
withHashRouter :: El1
withHashRouter = el _hashRouter

-- Props used for top level Routers

-- | Base URL for all locations. Should ideally have a leading slash but no trailing slash.
basename :: forall a. String -> P.Props a
basename = P.unsafeMkProp "basename"

-- | Only affects HashRouter
-- | If true, the URL style will be like `#` and `#sunshine/lollipops`
-- | If false (the default setting), the URL style will be like `#/` and `#/sunshine/lollipops`
noLeadingSlash :: forall a. Boolean -> P.Props a
noLeadingSlash p = P.unsafeMkProp "hashType" (if p then "noslash" else "slash")

-- Private
pathProp :: RoutePattern -> Array R.Props
pathProp pattern = case getPathFrom pattern of
  Nothing -> []
  Just path -> [R.unsafeMkProps "path" path]

-- Private
exactProp :: RoutePattern -> Array R.Props
exactProp pattern = if isExact pattern then [R.unsafeMkProps "exact" ""] else []

-- | Connect a route pattern and a route handler
route :: forall a. RoutePattern -> Array (Widget HTML a) -> Widget HTML a
route pattern ws = wrapViewEvent mkView (orr ws)
  where
  mkView h v =
    [ _route
      ([R.unsafeMkProps "component" (mkEffectFn1 (handler' v))]
        <> exactProp pattern
        <> pathProp pattern
      )
    ]
  handler' v a = do
    debugShow "ROUTE" a
    pure v

-- | Link to a route
linkTo :: String -> El
linkTo path props = el' _link ([P.unsafeMkProp "to" path] <> props)

-- | Use this prop on `switch` to switch on this location instead of the actual browser location
location :: forall a s. RouteHandlerArgs s -> P.Props a
location = P.unsafeMkProp "location"

-- | Switch between multiple routes
switch :: El
switch = el' _switch
