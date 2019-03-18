# Purescript Concur React Router

React Router bindings for Purescript Concur React.

## Documentation

**TODO**

There are a few components available to you -

Wrap everything that uses routes in `withBrowserRouter` (HTML5 location api) or `withHashRouter` (old style hash based routing). You can use props like `basename` and `noLeadingSlash` to fine tune the routing behaviour. Usually you will wrap your entire application in one top level `withBrowserRouter` component.

Then you can use `route` to match specific routes pattern and display some widgets. The widgets passed to route will only be displayed if the route pattern successfully matches. You can have dynamic widgets as usual with Concur.

You use `switch` to *exclusively* match routes. Only the *first* route that matches inside a switch will be rendered. For example, to provide a 404 page, put a route at the end with a `CatchAll` route.

To allow the user to switch routes, you can provide links with `linkTo`.

## Example

A simple example with dynamic routes is available at https://github.com/ajnsit/purescript-concur-react-router/blob/master/src/Main.purs.

You can see it running at - https://ajnsit.github.io/purescript-concur-react-router

## TODO - In order of importance

1. Allow accessing route match parameters.
2. *Typed Routes*.
