module.exports = (grunt)->
  imports = grunt.file.readJSON 'app/imports.json'
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

 
    coffee:
      compile:
        files:
          'public/js/app.js' : ['app/**/*.coffee']
        options:
          sourceMap: yes
          join: yes
          bare: yes
        
      # precompile source and unit tests for code coverage tools
      compileForTests:
        options:
          bare: yes
        expand: yes
        flatten: no
        cwd: 'app/'
        src: ['**/*.coffee']
        dest: 'test/js/'
        ext: '.js'

      compileTests:
        options:
          bare: yes
        expand: yes
        flatten: no
        cwd: 'test/unit/'
        src: ['**/*.coffee']
        dest: 'test/js-unit/'
        ext: '.spec.js'


    concat:
      options:
        separator: ';\n\n'
      vendorScripts:
        # Put specific bower-related vendor imports here. Don't include complete vendor dir, but select files explicitly to maintain control over loading order.
        src: imports.scripts
        dest: 'public/js/vendor.js'



    watch:
      options:
        livereload: yes

      scripts:  
        files: 'app/**/*.coffee'
        tasks: ['buildScripts']

      vendorScripts:
        files: 'vendor/**/*.js'
        tasks: ['concat:vendorScripts']

      templates:
        files: 'app/**/*.jade'
        tasks: ['buildTemplates']

      styles:
        files: ['app/**/*.scss']
        tasks: ['buildStyles']
        options: livereload: no

    jade:
      default:
        options:
          client: no
          wrap: no
          basePath: 'app/src'
          pretty: yes
        files:
          'public/': ['app/src/**/*.jade']

    html2js:
      options:
        module: 'templates'
        base: 'public/'

      main:
        src: 'public/**/*.html'
        dest: 'public/js/templates.js'

  # TODO: add compress
    compass:
      compile:
        options:
          config: 'config.rb'
          # imagesDir: 'assets/img'
          # httpImagesPath: '../img'
          # sassDir: 'app/styles'
          # cssDir: 'public/css'
          # require: 'sass-css-importer'


          # TODO: enable when compass gets updated with source maps support
          # raw: """
          #   sass_options = { 
          #     :sourcemap => true
          #   }
          #   """
      compileCompressed:
        options:
          imagesDir: 'img'
          sassDir: 'app/styles'
          cssDir: 'public/css'
          outputStyle: 'compressed'


    connect:
      server:
        options:
          port: 8081
          base: 'public'
          keepalive: yes


      livereload:
        options:
          port: 8081
          base: 'public'

    copy:
      assets:
        files:[
          src:['**'], dest:'public/', cwd:'assets/', expand: yes
        ]

    clean:
      public:
        src: ['public/*.*']
      templates:
        src: ['public/partials/**/*.*', 'public/index.html']
      scripts:
        src: ['public/js/']
      testScripts:
        src: ['test/js/', 'test/coverage', 'test/js-unit']
      styles:
        src: ['public/css/']


  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-livereload'
  grunt.loadNpmTasks 'grunt-jade'
  grunt.loadNpmTasks 'grunt-html2js'

  grunt.registerTask 'buildScripts', ['clean:scripts', 'copy:assets', 'coffee:compile', 'concat:vendorScripts', 'html2js:main', 'livereload', 'coffee:compileForTests', 'coffee:compileTests']

  grunt.registerTask 'buildTemplates', ['clean:templates', 'copy:assets', 'jade', 'html2js:main', 'livereload']

  grunt.registerTask 'buildStyles', ['compass:compile']

  grunt.registerTask 'coverage', ['clean:testScripts', 'html2js:main', 'coffee:compileForTests', 'coffee:compileTests']

  grunt.registerTask 'default', [ 'connect:livereload', 'watch']
  # TODO: add new tasks
  # TODO: create INIT / Bootstrap task
  # grunt.registerTask 'base', ['clean:public', 'copy:assets', 'coffee', 'jade', 'compass']
