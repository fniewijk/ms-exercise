var path = require("path");
module.exports = {
  module: {
    loaders: [
      { test: /\.json$/,   loader: "json-loader" },
      { test: /\.coffee$/, loader: "coffee-loader" },
      { test: /\.css$/,    loader: "style-loader!css-loader" },
      { test: /\.less$/,   loader: "style-loader!css-loader!less-loader" },
      { test: /\.html$/,   loader: "raw" },
      { test: /\.(png|gif|jpg|eot|woff|svg|ttf)$/, loader: "file?name=[path][name].[ext]" }
    ]
  },
  bail: true,
  cache: true
};
