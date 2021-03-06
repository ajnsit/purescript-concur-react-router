exports._browserRouterComponent = require("react-router-dom").BrowserRouter;
exports._hashRouterComponent = require("react-router-dom").HashRouter;
exports._routeComponent = require("react-router-dom").Route;
exports._switchComponent = require("react-router-dom").Switch;
exports._linkComponent = require("react-router-dom").Link;
exports._redirectComponent = require("react-router-dom").Redirect;

function debugShow(s) {
    return function(a) {
        return function() {
            console.log("DEBUG", s, a);
        };
    };
}

exports.debugShow = debugShow;

function toString(a) {
    return JSON.stringify(a, null, 2); // ("" + a);
}

exports.toString = toString;
