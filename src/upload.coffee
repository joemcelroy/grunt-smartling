baseUrl   = "https://api.smartling.com/v1/file/upload?"

fs            = require 'fs' 
request       = require 'request'
querystring   = require "querystring"

class SmartlingUpload

  constructor:(@grunt, @options, @callback) ->
    @uploadFile()
    
  generateQueryString: (locale) ->
    querystring.stringify {
      apiKey:     @options.apiKey
      projectId:  @options.projectId
      fileUri:    @options.resourceId
      approved:   true
      fileType:   "json"
    }

  uploadFile: (locale, callback) ->

    r = request.post {
      url:  baseUrl + @generateQueryString(locale)
    }, @handleUploadResponse

    form = r.form()
    form.append 'file', fs.createReadStream(@options.src)

  handleUploadResponse: (err, response, body) =>
    data = JSON.parse(body)?.response?.data
      
    unless err and data.code is "SUCCESS"
      @grunt.log.write "Success uploading to smartling. "
    else
      @grunt.log.write "Error", body

    @callback(err)

  
module.exports = (grunt, options, callback) -> new SmartlingUpload(grunt, options, callback)
