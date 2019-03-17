module Concur.React.Router.FFI where

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.Props as P
import Concur.React.Router.Types (RouteHandlerArgs)
import Data.Function.Uncurried (mkFn1)
import Data.Monoid (mempty)
import Data.Unit (Unit)
import Effect (Effect)
import React (Children, ReactClass, ReactElement, createElement)
import React.DOM.Props (unsafeFromPropsArray)
import React.DOM.Props as R

type ForeignRouterReactComponent = ReactClass { children :: Children }

foreign import _browserRouterComponent :: ForeignRouterReactComponent
foreign import _hashRouterComponent :: ForeignRouterReactComponent
foreign import _routeComponent :: ForeignRouterReactComponent
foreign import _switchComponent :: ForeignRouterReactComponent
foreign import _linkComponent :: ForeignRouterReactComponent

foreign import debugShow :: forall a. String -> a -> Effect Unit

_browserRouter :: Array R.Props -> Array ReactElement -> ReactElement
_browserRouter props children = createElement _browserRouterComponent (unsafeFromPropsArray props :: {}) children

_hashRouter :: Array R.Props -> Array ReactElement -> ReactElement
_hashRouter props children = createElement _hashRouterComponent (unsafeFromPropsArray props :: {}) children

_route :: Array R.Props -> ReactElement
_route props = createElement _routeComponent (unsafeFromPropsArray props :: {}) mempty

_link :: Array R.Props -> Array ReactElement -> ReactElement
_link props = createElement _linkComponent (unsafeFromPropsArray props :: {})

_switch :: Array R.Props -> Array ReactElement -> ReactElement
_switch props = createElement _switchComponent (unsafeFromPropsArray props :: {})
