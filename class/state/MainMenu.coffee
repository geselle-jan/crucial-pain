TinyRPG.MainMenu = (game) ->

TinyRPG.MainMenu.prototype =
    create: ->
        game.mode = 'menu'
        game.stage.setBackgroundColor '#000000'
        window.splashScreen = @add.sprite 0, 0, 'titlescreen'
        splashScreen.animations.add 'loop', [
            0
            1
            2
        ], 10, true
        splashScreen.animations.play 'loop'
        game.state.states.Default.create()
        game.ui.blank.hide()
        return
    startGame: ->
        game.ui.blank.fadeTo ->
            game.state.clearCurrentState()
            game.state.start 'Town'
        return
    update: ->
        game.state.states.Default.update()
        if game.controls.primary
            @startGame()
        return
    render: ->