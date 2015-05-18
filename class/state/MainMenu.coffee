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

        unless game.music
            game.music = game.add.audio 'noise'
            game.music.onDecoded.addOnce (->
                game.music.fadeIn 800, yes
            ), @
        else
            game.music.onFadeComplete.addOnce (->
                game.music = game.add.audio 'noise'
                game.music.onDecoded.addOnce (->
                    game.music.fadeIn 800, yes
                ), @
            ), @
            game.music.fadeOut 800

        game.ui.blank.fadeFrom()
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