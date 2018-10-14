const path = require('path');

module.exports = {
  entry: path.resolve(__dirname, 'frontend/js/app.js'),
  output: {
    path: __dirname + '/public/assets/_fe',
    filename: "bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel-loader"
      },
      {
        test: /\.scss/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              url: false,
              importLoaders: 2
            },
          },
          {
            loader: 'sass-loader',
          }
        ]
      }
    ]
  }
};