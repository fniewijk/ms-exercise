module.exports = function (config, coverage, junit) {
  coverage = coverage || process.env.COVERAGE;
  junit = junit || process.env.JUNIT;

  var reporters = coverage ? ['dots', 'coverage'] : ['dots'];

  if (junit) {
    reporters.push('junit');
  }

  config.set({
    basePath: '',

    browsers: ['PhantomJS'],

    coverageReporter: {
      type: 'html',
      dir: 'coverage/',
      subdir: function (browser) {
        return browser.toLowerCase().split(/[ /-]/)[0];
      }
    },

    files: [
      'main.coffee',
      'test/main.coffee',
      '**/*.test.coffee'
    ],

    junitReporter: {
      outputFile: 'test-results.xml'
    },

    frameworks: ['mocha', 'sinon-chai'],

    plugins: [
      'karma-coverage',
      'karma-junit-reporter',
      'karma-mocha',
      'karma-phantomjs-launcher',
      'karma-sinon-chai',
      'karma-webpack'
    ],

    preprocessors: {
      'main.coffee': ['webpack'],
      'test/*.coffee': ['webpack'],
      '**/*.test.coffee': ['webpack']
    },

    reporters: reporters,

    singleRun: true,

    webpack: {
      resolve: {
        extensions: ['', '.js', '.coffee']
      },
      module: {
        loaders: [
          { test: /\.json$/,   loader: 'json-loader' },
          { test: /\.coffee$/, loader: 'coffee-loader' },
          { test: /\.css$/,    loader: 'style-loader!css-loader' },
          { test: /\.less$/,   loader: 'style-loader!css-loader!less-loader' },
          { test: /\.html$/,   loader: 'raw' },
          { test: /\.(png|gif|jpg|eot|woff|svg|ttf)$/, loader: 'file?name=[path][name].[ext]' }
        ],
        postLoaders: coverage ? [
          { test: /\.coffee/, exclude: /\.test.coffee/, loader: 'istanbul-instrumenter' }
        ] : null
      }
    },

    webpackMiddleware: {
      noInfo: true
    }

  });
};
