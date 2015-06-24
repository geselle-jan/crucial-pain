CrucialPain.MainMenu = (game) ->

CrucialPain.MainMenu.prototype =
    create: ->
        game.mode = 'menu'
        game.stage.setBackgroundColor '#000000'
        splashScreen = @add.sprite scaleManager.levelOffsetX, scaleManager.levelOffsetY, 'titlescreen'
        splashScreen.scale.set 1 / scaleManager.scale
        splashScreen.animations.add 'loop', [
            0
            1
            2
        ], 10, true
        splashScreen.animations.play 'loop'
        game.state.states.Default.create()

        unless game.volume?
            game.volume =
                music: 1
                fx: 1

        unless game.fx?
            game.fx = new FX

        unless game.music?
            game.music = game.add.audio 'intro'
            game.music.volume = game.volume.music
            if game.volume.music > 0
                game.music.onDecoded.addOnce (->
                    game.music.fadeIn 800, yes
                ), @
        else
            if game.volume.music > 0
                game.music.onFadeComplete.addOnce (->
                    game.music = game.add.audio 'intro'
                    game.music.volume = game.volume.music
                    game.music.onDecoded.addOnce (->
                        game.music.fadeIn 800, yes
                    ), @
                ), @
            unless game.music.name is 'intro'
                game.music.fadeOut 800
            if game.music.volume is 0
                game.music.fadeOut 800

        game.ui.blank.fadeFrom()
        window.analytics?.trackView 'Title Screen'
        return
    startLevelSelect: ->
        game.ui.blank.fadeTo ->
            game.state.clearCurrentState()
            game.state.start 'LevelSelect'
        return
    update: ->
        game.state.states.Default.update()
        if game.controls.primary
            @startLevelSelect()
        return
    render: ->