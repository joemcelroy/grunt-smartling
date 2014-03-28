(function() {
  var SmartlingUpload, baseUrl, fs, querystring, request,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  baseUrl = "https://api.smartling.com/v1/file/upload?";

  fs = require('fs');

  request = require('request');

  querystring = require("querystring");

  SmartlingUpload = (function() {
    function SmartlingUpload(grunt, options, callback) {
      this.grunt = grunt;
      this.options = options;
      this.callback = callback;
      this.handleUploadResponse = __bind(this.handleUploadResponse, this);
      this.uploadFile();
    }

    SmartlingUpload.prototype.generateQueryString = function(locale) {
      return querystring.stringify({
        apiKey: this.options.apiKey,
        projectId: this.options.projectId,
        fileUri: this.options.resourceId,
        approved: true,
        fileType: "json"
      });
    };

    SmartlingUpload.prototype.uploadFile = function(locale, callback) {
      var form, r;
      r = request.post({
        url: baseUrl + this.generateQueryString(locale)
      }, this.handleUploadResponse);
      form = r.form();
      return form.append('file', fs.createReadStream(this.options.src));
    };

    SmartlingUpload.prototype.handleUploadResponse = function(err, response, body) {
      var data, _ref, _ref1;
      data = (_ref = JSON.parse(body)) != null ? (_ref1 = _ref.response) != null ? _ref1.data : void 0 : void 0;
      if (!(err && data.code === "SUCCESS")) {
        this.grunt.log.write("Success uploading to smartling. ");
      } else {
        this.grunt.log.write("Error", body);
      }
      return this.callback(err);
    };

    return SmartlingUpload;

  })();

  module.exports = function(grunt, options, callback) {
    return new SmartlingUpload(grunt, options, callback);
  };

}).call(this);
