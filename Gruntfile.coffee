module.exports = (grunt) ->
  grunt.initConfig
    slim:
      options:
        pretty: true
      crx:
        files: [
          expand: true
          cwd: 'src/slim/'
          src: '**/*.slim'
          dest: 'extension/html'
          ext: '.html'
        ]

    coffee:
      crx:
        files:[
          expand: true
          cwd: 'src/coffee'
          src: ['**/*.coffee']
          dest: 'extension/js/'
          ext: '.js'
        ]

    cson:
      manifest:
        expand: true
        flatten: true
        src: ['src/manifest.cson' ]
        dest: 'extension'
        ext: '.json'

      locales_ja:
        expand: true
        flatten: true
        src: ['src/locales/ja/*' ]
        dest: 'extension/_locales/ja'
        ext: '.json'

      locales_en:
        expand: true
        flatten: true
        src: ['src/locales/en/*' ]
        dest: 'extension/_locales/en'
        ext: '.json'

    copy:
      lib:
        files: [
          {
            expand: true
            cwd: 'node_modules/emojidex/dist/js'
            src: '**/*'
            dest: 'extension/js/lib'
          }
          {
            expand: true
            cwd: 'node_modules/emojidex/dist/css'
            src: '**/*'
            dest: 'extension/css/lib'
          }
          {
            expand: true
            cwd: 'bower_components/jquery.storageapi'
            src: 'jquery.storageapi.min.js'
            dest: 'extension/js/lib'
          }
          {
            expand: true
            cwd: 'bower_components/jquery/dist'
            src: 'jquery.min.js'
            dest: 'extension/js/lib'
          }
        ]
      img:
        files: [
          {
            expand: true
            cwd: 'src/img'
            src: '**/*'
            dest: 'extension/img'
          }
        ]
      css:
        files: [
          {
            expand: true
            cwd: 'src/css'
            src: '**/*'
            dest: 'extension/css'
          }
        ]

    watch:
      manifest:
        files: 'src/manifest.cson'
        tasks: ['cson:manifest']
      locales_ja:
        files: 'src/locales/ja/*'
        tasks: ['cson:locales_ja']
      locales_en:
        files: 'src/locales/en/*'
        tasks: ['cson:locales_en']
      slim:
        files: 'src/slim/**/*'
        tasks: ['slim']
      coffee:
        files: 'src/coffee/**/*'
        tasks: ['copy', 'coffee']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-cson'
  grunt.loadNpmTasks 'grunt-slim'
  grunt.registerTask 'default', ['cson', 'copy', 'slim', 'coffee']
  grunt.registerTask 'dev', ['watch']
