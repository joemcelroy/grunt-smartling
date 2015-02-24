module.exports = (grunt) ->

  grunt.initConfig

    coffee:
      compile:{
        expand: true,
        flatten: true,
        cwd: 'src',
        src: ['*.coffee'],
        dest: 'lib/',
        ext: '.js'
      }



    smartling_download:
      options:
        apiKey: "xxx"
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
        dest: "./test"

      resxTest:
        locales: [
          "en-GB"
          "es-MX"
        ]
        resourceId: "/files/Global.resx"
        # Optionally use filename for destination different from resourceId.
        downloadName: "Global"
        dest: "./test"
        # Optionally specify fileType other than json
        fileType: "resx"

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


