CrucialPain.Preloader = (game) ->

CrucialPain.Preloader.prototype =
    preload: ->
        @stage.backgroundColor = '#000000'
        @preloadBar = new PreloadBar(
            bg: 'preloaderBg'
            bar: 'preloaderBar'
            center: yes)
        @load.setPreloadSprite @preloadBar.getSprite()
        #console.log @preloadBar.getSprite()
        @load.spritesheet 'titlescreen', 'asset/sprites/titlescreen.png', 1024, 768

        @load.spritesheet 'cursor', 'asset/sprites/cursor.png', 48, 48

        @load.spritesheet 'puck', 'asset/sprites/puck.png', 96, 192
        @load.spritesheet 'crab', 'asset/sprites/crab.png', 96, 96
        @load.spritesheet 'hermit', 'asset/sprites/hermit.png', 96, 96
        @load.spritesheet 'movingwall', 'asset/sprites/movingwall.png', 72, 96
        @load.spritesheet 'stopper', 'asset/sprites/stopper.png', 72, 96
        @load.spritesheet '1up', 'asset/sprites/1up.png', 96, 96
        @load.spritesheet '1upsmoke', 'asset/sprites/1upsmoke.png', 96, 96
        @load.spritesheet 'portal', 'asset/sprites/portal.png', 96, 96
        @load.spritesheet 'portalsmoke', 'asset/sprites/portalsmoke.png', 96, 96
        @load.spritesheet 'goal', 'asset/sprites/goal.png', 96, 96
        @load.spritesheet 'goalsmoke', 'asset/sprites/goalsmoke.png', 96, 96

        @load.spritesheet 'wall_1x1', 'asset/sprites/wall_1x1.png', 72, 96
        @load.spritesheet 'wall_1x2', 'asset/sprites/wall_1x2.png', 72, 136
        @load.spritesheet 'wall_1x3', 'asset/sprites/wall_1x3.png', 72, 176
        @load.spritesheet 'wall_2x1', 'asset/sprites/wall_2x1.png', 112, 96
        @load.spritesheet 'wall_3x1', 'asset/sprites/wall_3x1.png', 152, 96

        @load.spritesheet 'gate_vert_idle1', 'asset/sprites/gate_vert_idle1.png', 56, 56
        @load.spritesheet 'gate_vert_idle2', 'asset/sprites/gate_vert_idle2.png', 56, 56

        @load.spritesheet 'gate_horiz_idle1', 'asset/sprites/gate_horiz_idle1.png', 56, 96
        @load.spritesheet 'gate_horiz_idle2', 'asset/sprites/gate_horiz_idle2.png', 56, 96
        
        @load.spritesheet 'gate_N_base', 'asset/sprites/gate_N_base.png', 56, 64
        @load.spritesheet 'gate_S_base', 'asset/sprites/gate_S_base.png', 56, 64
        @load.spritesheet 'gate_W_base', 'asset/sprites/gate_W_base.png', 32, 96
        @load.spritesheet 'gate_E_base', 'asset/sprites/gate_E_base.png', 32, 96
        
        @load.spritesheet 'gate_N_front', 'asset/sprites/gate_N_front.png', 56, 64
        @load.spritesheet 'gate_S_front', 'asset/sprites/gate_S_front.png', 56, 56
        @load.spritesheet 'gate_W_front', 'asset/sprites/gate_W_front.png', 48, 96
        @load.spritesheet 'gate_E_front', 'asset/sprites/gate_E_front.png', 48, 96

        @load.tilemap '1', 'asset/level/1.json', null, Phaser.Tilemap.TILED_JSON
        @load.tilemap '2', 'asset/level/2.json', null, Phaser.Tilemap.TILED_JSON
        @load.tilemap '3', 'asset/level/3.json', null, Phaser.Tilemap.TILED_JSON
        @load.tilemap '4', 'asset/level/4.json', null, Phaser.Tilemap.TILED_JSON
        @load.tilemap '5', 'asset/level/5.json', null, Phaser.Tilemap.TILED_JSON
        @load.tilemap '6', 'asset/level/6.json', null, Phaser.Tilemap.TILED_JSON
        @load.tilemap '7', 'asset/level/7.json', null, Phaser.Tilemap.TILED_JSON
        @load.tilemap '8', 'asset/level/8.json', null, Phaser.Tilemap.TILED_JSON

        @load.bitmapFont 'silkscreen', 'asset/fonts/silkscreen/silkscreen.png', 'asset/fonts/silkscreen/silkscreen.fnt'
        return
    create: ->
        @state.start 'MainMenu'
    render: ->