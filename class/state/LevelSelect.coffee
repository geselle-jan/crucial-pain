CrucialPain.LevelSelect = (game) ->

CrucialPain.LevelSelect.prototype =
    create: ->
        game.mode = 'menu'
        game.stage.setBackgroundColor '#000000'

        levelCount = 0
        while game.cache._tilemaps[''+(levelCount + 1)+'']
            levelCount++
            new Button(
                x: (100 * ((levelCount - 1) % 10)) + 42 + scaleManager.levelOffsetX
                y: (88 * Math.floor((levelCount - 1) / 10)) + 72 + scaleManager.levelOffsetY
                label: '' + levelCount + '')

        game.state.states.Default.create()
        game.ui.blank.hide()
        return
    update: ->
        game.state.states.Default.update()
        return
    render: ->