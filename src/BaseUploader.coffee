fs            = require 'fs'
request       = require 'request'
querystring   = require "querystring"

class BaseUploader

  constructor:(@grunt, @options, @callback) ->
    @uploadFile()

  action:()-> "Uploading"

  baseUrl:->

  getParams:()->

  generateQueryString:()->
    querystring.stringify @getParams()

  uploadFile: () ->
    url = @baseUrl() + @generateQueryString()
    @grunt.log.write "Begin #{@action()} to: #{@baseUrl()}"
    @grunt.log.write JSON.stringify(@getParams(), null, 2)
    r = request.post {
      url:url
    }, @handleUploadResponse

    form = r.form()
    form.append 'file', fs.createReadStream(@options.src)

  handleUploadResponse: (err, response, body) =>
    data = JSON.parse(body)?.response?.data

    unless err and data.code is "SUCCESS"
      @grunt.log.write "Success #{@action()} to smartling. "
    else
      @grunt.log.write "Error", body

    @callback(err)

module.exports = BaseUploader