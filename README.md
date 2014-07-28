grunt-smartling
===================

Allows you upload and download resource files from smartling via grunt commands

This plugin is actually three distinct multi-tasks, bundled together for convenience:
- smartling_download
- smartling_upload
- smartling_import

These multi-tasks each have seperate configs, support multiple targets, and can be run individually.

How to use

```
    smartling_download:
      options:
        apiKey:"xxx"
        projectId: "xxx"
        
      default:
        locales: [
          "en-GB"
          "es-MX"
          "de-DE"
          "fr-CA"
          "ja-JP"
        ]
        resourceId: "myProject.resource"
        dest: "/test"

      mobile:
        locales: [
          "en-GB"
          "es-MX"
        ]
        resourceId: "myProjectMobile.resource"
        dest: "/test"


    smartling_upload:
      options:
        apiKey:"xxx"
        projectId: "xxx"

      default:
        resourceId: "myProject.resource"
        src: "test/resources/myProject.resource.json"

      mobile:
        resourceId: "myProjectMobile.resource"
        src: "test/resources/myProjectMobile.resource.json"


    smartling_import:
      options:
        apiKey:"xxx"
        projectId: "xxx"
        locale           : "en-GB"
        overwrite        : false
        translationState : "IN_EDITING"

      default:
        resourceId : "myProject.resource"
        src        : "test/resources/myProject.resource.json"

      mobile:
        resourceId: "myProjectMobile.resource"
        src: "test/resources/myProjectMobile.resource.json"

```


NOTE: For JSON uploads to smartling, the following config may be required within the JSON file:

      {
        "smartling": {
          "translate_mode" : "all",
          "placeholder_format_custom": ["\\{\\{.*?\\}\\}"],
          "source_key_paths": ["/{*}/"]
        }
      }