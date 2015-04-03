CrucialPain.Preloader = (game) ->

CrucialPain.Preloader.prototype =
    preload: ->
        @stage.backgroundColor = '#000000'
        @preloadBar = new PreloadBar(
            bg: 'preloaderBg'
            bar: 'preloaderBar'
            center: yes)
        @load.setPreloadSprite @preloadBar.getSprite()

        @load.spritesheet 'titlescreen', 'asset/sprites/titlescreen.png', 1024, 768

        @load.spritesheet 'cursor', 'asset/sprites/cursor.png', 48, 48

        @load.spritesheet 'goal', 'asset/sprites/goal.png', 96, 96
        @load.spritesheet 'puck', 'asset/sprites/puck.png', 96, 192

        @load.spritesheet 'wall_1x1', 'asset/sprites/wall_1x1.png', 72, 96
        @load.spritesheet 'wall_1x2', 'asset/sprites/wall_1x2.png', 72, 136
        @load.spritesheet 'wall_1x3', 'asset/sprites/wall_1x3.png', 72, 176
        @load.spritesheet 'wall_2x1', 'asset/sprites/wall_2x1.png', 112, 96
        @load.spritesheet 'wall_3x1', 'asset/sprites/wall_3x1.png', 152, 96

        @load.tilemap '1', 'asset/level/1.json', null, Phaser.Tilemap.TILED_JSON

        @load.bitmapFont 'silkscreen', 'asset/fonts/silkscreen/silkscreen.png', 'asset/fonts/silkscreen/silkscreen.fnt'
        return
    create: ->
        @state.start 'MainMenu'
    render: ->