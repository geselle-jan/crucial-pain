TinyRPG.Preloader = (game) ->

TinyRPG.Preloader.prototype =
    preload: ->
        @stage.backgroundColor = '#000000'
        @preloadBar = new PreloadBar(
            bg: 'preloaderBg'
            bar: 'preloaderBar'
            center: yes)
        @load.setPreloadSprite @preloadBar.getSprite()


        @load.spritesheet 'titlescreen', 'asset/sprites/titlescreen.png', 1024, 768
        @load.spritesheet 'cursor', 'asset/sprites/cursor.png', 48, 48


        @load.image 'menubg', 'asset/backgrounds/main-menu.png'
        @load.image 'boxborder', 'asset/sprites/box_border.png'
        @load.image 'boxborderactive', 'asset/sprites/box_border_active.png'
        @load.image 'menuclickable', 'asset/sprites/menu_clickable.png'
        @load.spritesheet 'startbutton', 'asset/sprites/start_button.png', 59, 38
        @load.spritesheet 'textbox', 'asset/sprites/textbox.png'
        @load.spritesheet 'foemarker', 'asset/sprites/foe_marker.png'
        @load.spritesheet 'statusinfo', 'asset/sprites/status_info.png'
        @load.spritesheet 'tiny16', 'asset/tilesets/tiny16.png', 64, 64
        @load.spritesheet 'collision', 'asset/tilesets/collision.png', 64, 64
        @load.tilemap 'town', 'asset/rooms/town.json', null, Phaser.Tilemap.TILED_JSON
        @load.bitmapFont 'silkscreen', 'asset/fonts/silkscreen/silkscreen.png', 'asset/fonts/silkscreen/silkscreen.fnt'
        return
    create: ->
        @state.start 'MainMenu'
    render: ->