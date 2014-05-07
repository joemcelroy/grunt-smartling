(function() {
  var BaseUploader, fs, querystring, request,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  fs = require('fs');

  request = require('request');

  querystring = require("querystring");

  BaseUploader = (function() {
    function BaseUploader(grunt, options, callback) {
      this.grunt = grunt;
      this.options = options;
      this.callback = callback;
      this.handleUploadResponse = __bind(this.handleUploadResponse, this);
      this.uploadFile();
    }

    BaseUploader.prototype.action = function() {
      return "Uploading";
    };

    BaseUploader.prototype.baseUrl = function() {};

    BaseUploader.prototype.getParams = function() {};

    BaseUploader.prototype.generateQueryString = function() {
      return querystring.stringify(this.getParams());
    };

    BaseUploader.prototype.uploadFile = function() {
      var form, r, url;
      url = this.baseUrl() + this.generateQueryString();
      this.grunt.log.write("Begin " + (this.action()) + " to: " + (this.baseUrl()));
      this.grunt.log.write(JSON.stringify(this.getParams(), null, 2));
      r = request.post({
        url: url
      }, this.handleUploadResponse);
      form = r.form();
      return form.append('file', fs.createReadStream(this.options.src));
    };

    BaseUploader.prototype.handleUploadResponse = function(err, response, body) {
      var data, _ref, _ref1;
      data = (_ref = JSON.parse(body)) != null ? (_ref1 = _ref.response) != null ? _ref1.data : void 0 : void 0;
      if (!(err && data.code === "SUCCESS")) {
        this.grunt.log.write("Success " + (this.action()) + " to smartling. ");
      } else {
        this.grunt.log.write("Error", body);
      }
      return this.callback(err);
    };

    return BaseUploader;

  })();

  module.exports = BaseUploader;

}).call(this);
