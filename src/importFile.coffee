BaseUploader = require "./BaseUploader"

class SmartlingImport extends BaseUploader

  baseUrl: -> "https://api.smartling.com/v1/file/import?"

  action:()-> "importing"

  getParams:()-> {
    apiKey           : @options.apiKey
    projectId        : @options.projectId
    fileUri          : @options.resourceId
    locale           : @options.locale
    overwrite        : @options.overwrite or false
    translationState : @options.translationState or "IN_EDITING"
    fileType         : @options.fileType or "json"
  }


module.exports = (grunt, options, callback) -> new SmartlingImport(grunt, options, callback)
