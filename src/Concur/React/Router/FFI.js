exports._browserRouterComponent = require("react-router-dom").BrowserRouter;
exports._hashRouterComponent = require("react-router-dom").HashRouter;
exports._routeComponent = require("react-router-dom").Route;
exports._switchComponent = require("react-router-dom").Switch;
exports._linkComponent = require("react-router-dom").Link;

function debugShow(s) {
    return function(a) {
        return function() {
            console.log("DEBUG", s, a);
        };
    };
}

exports.debugShow = debugShow;
