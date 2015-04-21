CrucialPain.LevelSelect = (game) ->

CrucialPain.LevelSelect.prototype =
    create: ->
        game.mode = 'menu'
        game.stage.setBackgroundColor '#000000'

        unless localStorage.getItem 'maxLevel'
            localStorage.setItem 'maxLevel', 1

        maxLevel = localStorage.getItem 'maxLevel'
        maxLevel = maxLevel * 1

        levelCount = 0
        while game.cache._tilemaps[''+(levelCount + 1)+'']
            levelCount++
            button = new Button(
                x: (100 * ((levelCount - 1) % 8)) + 143 + scaleManager.levelOffsetX
                y: (88 * Math.floor((levelCount - 1) / 8)) + 152 + scaleManager.levelOffsetY
                label: '' + levelCount + '')
            if maxLevel < levelCount
                button.sprite.alpha = 0.25
                button.text.alpha = 0.25
            

        game.state.states.Default.create()
        game.ui.blank.hide()
        return
    update: ->
        game.state.states.Default.update()
        return
    render: ->