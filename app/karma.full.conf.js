var defaultConfig = require('./karma.conf.js');

module.exports = function (config) {
  defaultConfig(config, true, true);
};
