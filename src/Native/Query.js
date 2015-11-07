var get = function get(Maybe) {
    return function (selector) {
        var node = document.querySelector(selector);

        if (node !== null){
            return Maybe.Just(node);
        }

        return Maybe.Nothing;
    };
};

var getAll = function get(List) {
    return function(selector){
        var nodes = document.querySelectorAll(selector);

        return List.fromArray(nodes);
    }
};

var eq = function eq() {
    return function(left, right){
        return left === right;
    };
};

var activeElement = function activeElement() {
    return function(){
        console.log("here", document.activeElement);
        return document.activeElement;
    };
};

var focus = function focus() {
    return function(node) {
        node.focus();
    };
};

var xOf = function xOf(){
    return function(node, attributeName){
        return node[attributeName];
    };
};
var make = function make(localRuntime) {
    localRuntime.Native = localRuntime.Native || {};
    localRuntime.Native.Query = localRuntime.Native.Query || {};

    var Maybe = Elm.Maybe.make(localRuntime);
    var List = Elm.Native.List.make(localRuntime);


    if (localRuntime.Native.Query.values) {
        return localRuntime.Native.Query.values;
    }

    return {
        'get' : get(Maybe),
        'getAll': getAll(List),
        'eq' : F2(eq()),
        'activeElement' : activeElement(),
        'focus': focus()
    };
};
Elm.Native.Query = {};
Elm.Native.Query.make = make;

if (typeof window === "undefined") {
    window = global;
}
