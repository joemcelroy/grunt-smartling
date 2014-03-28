grunt-smartling
===================

Allows you upload and download resource files from smartling via grunt commands

How to use

```

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
        resourceId: "locale.resource"
        dest: "/test"

    smartling_upload:
      options:
        apiKey:"xxx"
        projectId: "xxx"

      test:
        resourceId: "locale.resource"
        src: "test/resources/resource.json"

```
