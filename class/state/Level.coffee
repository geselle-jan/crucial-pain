CrucialPain.Level = (game) ->

CrucialPain.Level.prototype =
    create: ->
        game.mode = 'level'
        game.physics.startSystem Phaser.Physics.ARCADE
        game.stage.setBackgroundColor '#000000'
        @stateChange = false

        game.levelIndex ?= 1

        @level = game.level = new Level(
            index: game.levelIndex)

        game.puck = new Puck()

        game.gate = new Gate(
            x: 410
            y: 464
            orientation: 'vertical',
            timeOpened: 1000
            timeClosed: 5000)

        game.state.states.Default.create()
        game.ui.blank.fadeFrom()
    update: ->
        that = this
        game.state.states.Default.update()
        if @stateChange
            @stateChange()

        @level.update()

        game.puck.update()

        game.gate.update()

        if game.puck.health <= 0 and game.mode isnt 'stateChange'
            game.mode = 'stateChange'
            game.ui.blank.fadeTo =>
                game.state.clearCurrentState()
                @state.start 'Level'

        if @level.goal.isReached() and game.mode isnt 'stateChange'
            game.levelIndex++
            game.mode = 'stateChange'
            game.ui.blank.fadeTo =>
                game.state.clearCurrentState()
                @state.start 'Level' 
    render: ->
        #game.debug.body game.puck.sprite