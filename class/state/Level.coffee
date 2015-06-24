CrucialPain.Level = (game) ->

CrucialPain.Level.prototype =
    create: ->
        game.mode = 'level'
        game.physics.startSystem Phaser.Physics.ARCADE
        game.stage.setBackgroundColor '#000000'
        @stateChange = false

        game.levelIndex ?= 1

        maxLevel = localStorage.getItem 'maxLevel'
        maxLevel = maxLevel * 1

        if game.levelIndex > maxLevel
            localStorage.setItem 'maxLevel', game.levelIndex

        @level = game.level = new Level(
            index: game.levelIndex)

        game.puck = new Puck()

        backButton = game.add.bitmapText(0, 0, 'astonished', 'back', 36)
        backButton.fixedToCamera = yes
        backButton.cameraOffset.x = 32
        backButton.cameraOffset.y = 16
        backButton.scale.set scaleManager.scale
        backButton.inputEnabled = yes
        backButton.events.onInputDown.add @startLevelSelect, @

        game.music.onFadeComplete.addOnce (->
            game.music = game.add.audio 'full'
            if game.volume.music > 0
                game.music.onDecoded.addOnce (->
                    game.music.fadeIn 800, yes
                ), @
        ), @
        unless game.music.name is 'full'
            game.music.fadeOut 800

        game.state.states.Default.create()
        game.ui.blank.fadeFrom()
        window.analytics?.trackView 'Level ' + game.levelIndex
    update: ->
        that = this
        game.state.states.Default.update()
        if @stateChange
            @stateChange()

        @level.update()

        game.puck.update()

        if game.puck.health <= 0 and game.mode isnt 'stateChange'
            game.mode = 'stateChange'
            game.ui.blank.fadeTo =>
                game.state.clearCurrentState()
                @state.start 'Level'

        if @level.goal.isReached() and game.mode isnt 'stateChange'
            game.levelIndex++
            unless game.cache._tilemaps[''+game.levelIndex+'']
                game.mode = 'stateChange'
                game.ui.blank.fadeTo =>
                    game.state.clearCurrentState()
                    @state.start 'LevelSelect'
            else
                game.mode = 'stateChange'
                game.ui.blank.fadeTo =>
                    game.state.clearCurrentState()
                    @state.start 'Level'
    render: ->
        #game.debug.body game.puck.sprite
    startLevelSelect: ->
        game.mode = 'stateChange'
        game.ui.blank.fadeTo =>
            game.state.clearCurrentState()
            @state.start 'LevelSelect'