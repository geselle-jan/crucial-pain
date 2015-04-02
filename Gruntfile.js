/*global module:false*/
module.exports = function(grunt) {

    // Project configuration.
    grunt.initConfig({
        // Metadata.
        pkg: grunt.file.readJSON('package.json'),
        banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
            '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
            '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
            '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %> */\n',
        // Task configuration.
        coffee: {
            files: [
                'class/system/Helpers.coffee',
                'class/system/Controls.coffee',
                'class/entity/ui/Blank.coffee',
                'class/entity/ui/Box.coffee',
                'class/entity/ui/StatusInfo.coffee',
                'class/entity/ui/FPS.coffee',
                'class/entity/ui/TextBox.coffee',
                'class/entity/ui/PauseMenu.coffee',
                'class/entity/ui/Crosshair.coffee',
                'class/entity/ui/FoeView.coffee',
                'class/entity/ui/PreloadBar.coffee',
                'class/entity/map/Wall.coffee',
                'class/entity/character/Puck.coffee',
                'class/entity/character/npc/Skeletons.coffee',
                'class/entity/character/npc/Slimes.coffee',
                'class/entity/character/npc/Bats.coffee',
                'class/state/Boot.coffee',
                'class/state/Default.coffee',
                'class/state/Preloader.coffee',
                'class/state/MainMenu.coffee',
                'class/state/Level.coffee',
                'class/system/main.coffee'
            ],
            compile: {
                options: {
                    bare: true,
                    join: true
                },
                files: {
                    'compiled.js': '<%= coffee.files %>'
                }
            }
        },

        uglify: {
            options: {
                banner: '<%= banner %>'
            },
            dist: {
                src: 'compiled.js',
                dest: 'main.js'
            }
        },
        watch: {
            files: '<%= coffee.files %>',
            tasks: ['default']
        }
    });

    // These plugins provide necessary tasks.
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-qunit');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-watch');

    // Default task.
    grunt.registerTask('default', ['coffee:compile', 'uglify']);

};
