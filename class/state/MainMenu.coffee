CrucialPain.MainMenu = (game) ->

CrucialPain.MainMenu.prototype =
    create: ->
        game.mode = 'menu'
        game.stage.setBackgroundColor '#000000'
        window.splashScreen = @add.sprite scaleManager.levelOffsetX, scaleManager.levelOffsetY, 'titlescreen'
        window.splashScreen.scale.set 1 / scaleManager.scale
        splashScreen.animations.add 'loop', [
            0
            1
            2
        ], 10, true
        splashScreen.animations.play 'loop'
        game.state.states.Default.create()
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