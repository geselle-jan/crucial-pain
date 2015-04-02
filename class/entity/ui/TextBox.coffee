class TextBox

    constructor: ->
        @background = @createBackground()
        @text = @createText()
        @initalMode = game.mode
        @lastOpened = game.time.now
        @hide()
        @addEvents()

    addEvents: ->
        game.input.onDown.add (->
            if game.mode == 'dialog' and game.time.now - @lastOpened > 100
                @hide()
            return
        ), @

    createBackground: ->
        box = new Box(
            width: 224
            height: 48
            x: 32
            y: game.camera.height - 48 * 4 - 32)
        box.sprite

    createText: ->
        text = game.add.bitmapText(0, 0, 'silkscreen', '', 32)
        text.fixedToCamera = true
        text.cameraOffset.x = 56
        text.cameraOffset.y = game.camera.height - 200
        text

    hide: ->
        @background.visible = no
        @text.visible = no
        game.mode = @initalMode
        @

    show: (text) ->
        if text? then @text.setText text
        @lastOpened = game.time.now
        @background.visible = yes
        @text.visible = yes
        game.mode = 'dialog'
        @