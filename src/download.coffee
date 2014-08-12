baseUrl       = "https://api.smartling.com/v1/file/get?"

fs            = require 'fs'
request       = require 'request'
querystring   = require "querystring"
async         = require 'async'
path          = require 'path'


class SmartlingDownload

  constructor:(@grunt, @options, @callback) ->
    @fileType = @options.fileType or "json"
    @downloadName = @options.downloadName or @options.resourceId
    @run()

  run: ->
    async.each @options.locales, @getLocaleRequest, (err) =>
      @callback()

  generateQueryString: (locale) ->
    querystring.stringify {
      locale:     locale
      apiKey:     @options.apiKey
      projectId:  @options.projectId
      fileUri:    @options.resourceId
    }

  getLocaleRequest: (locale, callback) =>
    resourceFileName = "#{@downloadName}.#{locale}.#{@fileType}"
    dest = path.join(@options.dest, resourceFileName)

    @grunt.log.write "downloading #{locale} from smartling \n "

    r = request.get({url:(baseUrl + @generateQueryString(locale)), json:true}, callback)
    r.pipe(fs.createWriteStream(dest))


module.exports = (grunt, options, callback) -> new SmartlingDownload(grunt, options, callback)
