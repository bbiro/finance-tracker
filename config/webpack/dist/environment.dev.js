"use strict";

var _require = require('@rails/webpacker'),
    environment = _require.environment;

var webpack = require("webpack");

environment.plugins.append("Provide", new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}));
module.exports = environment;