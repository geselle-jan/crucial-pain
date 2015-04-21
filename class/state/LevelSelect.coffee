CrucialPain.LevelSelect = (game) ->

CrucialPain.LevelSelect.prototype =
    create: ->
        game.mode = 'menu'
        game.stage.setBackgroundColor '#00ff00'
        game.state.states.Default.create()
        game.ui.blank.hide()
        return
    startGame: ->
        game.ui.blank.fadeTo ->
            game.state.clearCurrentState()
            game.state.start 'Level'
        return
    update: ->
        game.state.states.Default.update()
        if game.controls.primary
            @startGame()
        return
    render: ->