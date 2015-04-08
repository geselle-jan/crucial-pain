CrucialPain = {}

CrucialPain.Boot = (game) ->

CrucialPain.Boot.prototype =
    preload: ->
        game.time.advancedTiming = true
        # preload the loading indicator first before anything else
        @load.image 'preloaderBg', 'asset/sprites/preload_bg.png'
        @load.image 'preloaderBar', 'asset/sprites/preload_bar.png'
        return
    create: ->
        game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
        game.scale.setScreenSize()
        game.scale.refresh()
        game.stage.disableVisibilityChange = true
        game.onBlur.add (->
            game.input.reset()
            game.inactive = true
            return
        ), this
        game.onFocus.add (->
            game.inactive = false
            return
        ), this
        # start the Preloader state
        @state.start 'Preloader'
        return