BaseUploader = require "./BaseUploader"

class SmartlingUpload extends BaseUploader

  baseUrl: -> "https://api.smartling.com/v1/file/upload?"

  getParams:()-> {
    apiKey:     @options.apiKey
    projectId:  @options.projectId
    fileUri:    @options.resourceId
    approved:   true
    fileType:   "json"
  }


module.exports = (grunt, options, callback) -> new SmartlingUpload(grunt, options, callback)
