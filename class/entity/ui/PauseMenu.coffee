class PauseMenu

    entries: [
        {
            name: 'Character'
            action: ->
                alert 'Character'
        }
        {
            name: 'Save'
            action: ->
                alert 'Save'
        }
        {
            name: 'Quit'
            action: ->
                alert 'Quit'
        }
    ]

    constructor: ->
        @scale = 4
        @background = @createBackground()
        @texts = []
        @clickables = []
        i = @entries.length - 1
        while i >= 0
            @entries[i].index = i
            @texts[i] = @createText i
            @clickables[i] = @createClickable i
            i--
        @activeIndicator = @createActiveIndicator()
        @initalMode = game.mode
        @lastOpened = game.time.now
        @hide()
        @bindEscDown()

    createBackground: ->
        boxHeight = 10 + @entries.length - 1 + @entries.length * 13
        box = new Box(
            width: 73
            height: boxHeight
            x: game.camera.width - 73 * @scale - 8 * @scale
            y: game.camera.height - boxHeight * @scale - 8 * @scale)
        box.sprite

    createText: (index) ->
        text = game.add.bitmapText 0, 0, 'silkscreen', @entries[index].name, 8 * @scale
        text.fixedToCamera = yes
        text.cameraOffset.x = 167 * @scale
        text.cameraOffset.y = game.camera.height - 10 * @scale - (@entries.length - index) * @scale * 14
        text

    bindInputOver: (item) ->
        item.events.onInputOver.add (->
            @activeIndicator.visible = yes
            @activeIndicator.cameraOffset.x = 157 * @scale
            @activeIndicator.cameraOffset.y = item.cameraOffset.y + 3 * @scale
        ), @

    bindInputOut: (item) ->
        item.events.onInputOut.add (->
            @activeIndicator.visible = no
        ), @

    bindInputDown: (item) ->
        item.events.onInputDown.add (->
            @hide()
            @entries[item.menuIndex].action?()
        ), @

    bindEscDown: ->
        game.controls.esc.onDown.add (->
            if game.mode is 'menu' and game.time.now - @lastOpened > 100
                @hide()
            else if game.mode is 'level'
                @show()
        ), @

    createClickable: (index) ->
        clickable = game.add.sprite 0, 0, 'menuclickable'
        clickable.menuIndex = index
        clickable.fixedToCamera = yes
        clickable.scale.setTo @scale
        clickable.cameraOffset.x = 164 * @scale
        clickable.cameraOffset.y = game.camera.height - 12 * @scale - (@entries.length - index) * @scale * 14
        clickable.data = @entries[index]
        clickable.inputEnabled = yes
        @bindInputOver clickable
        @bindInputOut clickable
        @bindInputDown clickable
        clickable

    createActiveIndicator: ->
        indicator = game.add.sprite 0, 0, 'boxborderactive'
        indicator.fixedToCamera = yes
        indicator.scale.setTo @scale
        indicator.cameraOffset.x = 0
        indicator.cameraOffset.y = 0
        indicator.visible = no
        indicator

    hide: ->
        @background.visible = no
        @activeIndicator.visible = no
        for text in @texts
            text.visible = no
        for clickable in @clickables
            clickable.visible = no
        game.mode = @initalMode
        @

    show: ->
        @lastOpened = game.time.now
        @background.visible = yes
        for text in @texts
            text.visible = yes
        for clickable in @clickables
            clickable.visible = yes
            if clickable.input.checkPointerOver(game.input.activePointer)
                clickable.events.onInputOver.dispatch()
        game.mode = 'menu'
        @