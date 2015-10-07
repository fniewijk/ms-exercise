var defaultConfig = require('./karma.conf.js');

module.exports = function (config) {
  defaultConfig(config);

  config.set({
    autoWatch: true,
    singleRun: false
  });
};
