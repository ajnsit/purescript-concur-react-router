module Main where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Concur.React.Router (linkTo, route, switch, withBrowserRouter, redirect)
import Concur.React.Router.FFI (toString)
import Concur.React.Router.Types (RoutePattern(..), RouteHandlerArgs)
import Concur.React.Run (runWidgetInDom)
import Effect (Effect)

main :: Effect Unit
main = runWidgetInDom "root" rootWidget

-- Compose pagesets together
rootWidget :: forall a. Widget HTML a
rootWidget = withBrowserRouter [] $ D.div'
  [ pagesetWithUsers *> pagesetWithoutUsers
  , links
  ]

showArgs :: forall a. RouteHandlerArgs -> Widget HTML a
showArgs = D.text <<< toString

links :: forall a. Widget HTML a
links = D.div'
  [ D.hr'
  , D.div' [linkTo "/about" [] [D.text "Go to ABOUT page"]]
  , D.div' [linkTo "/users" [] [D.text "Go to USERS page"]]
  , D.hr'
  , D.div' [D.text "Current Route information -"]
  , D.div' [route CatchAll showArgs]
  ]

-- Pagesets
pagesetWithUsers :: Widget HTML Unit
pagesetWithUsers = switch []
  [ route (Exact "/about") \args -> D.div'
    [ D.h1' [D.text "The About page"]
    , do
         void $ D.button [P.onClick] [D.text "Click ME"]
         void $ D.button [P.onClick] [D.text "If you click the button one more time, the users page will disappear!"]
    ]
  , route (Exact "/users") \args -> D.h1' [D.text "Users page"]
  , route CatchAll \args -> notFound
  ]

pagesetWithoutUsers :: forall a. Widget HTML a
pagesetWithoutUsers = switch []
  [ route (Exact "/about") \args -> D.div'
    [ D.h1' [D.text "About page."]
    , D.div'
      [D.text "Now you've done it! There is no more /users page! Dynamic route configuration!"]
    ]
 , route CatchAll \args -> notFound
 ]

notFound :: forall a. Widget HTML a
notFound = D.h1' 
  [ D.text "404 page"
  , D.div' 
    [ D.button [P.onClick] [D.text "Redirect 404 to ABOUT"] >>= \_ -> 
      redirect { to: "/about", push: false }
    ]
  ]
