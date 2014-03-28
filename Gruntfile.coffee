module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      compile:
        files: 
          'lib/download.js':'src/download.coffee'
          'lib/upload.js': 'src/upload.coffee'

    
    smartling_download:
      options:
        apiKey:"xxx"
        projectId: "xxx"
        
      test:
        locales: [
          "en-GB"
          "es-MX"
          "de-DE"
          "fr-CA"
          "ja-JP"
        ]
        resourceId: "MobileManager.resource"
        dest: "/test"

    smartling_upload:
      options:
        apiKey:"xxx"
        projectId: "xxx"

      test:
        resourceId: "MobileManager.resource"
        src: "test/resources/resource.json"



  grunt.loadTasks('tasks')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.registerTask "default", [
    'coffee',  'smartling_download'
  ]


