class Blank

    constructor: (options = {}) ->
        visible = options.visible ? no
        @color = options.color ? '#000000'
        @speed = options.speed ? 400
        @width = game.camera.width 
        @height = game.camera.height
        @x = 0
        @y = 0
        @sprite = @createSprite()
        @sprite.visible = visible
        @sprite.alpha = if visible then 1 else 0

    createBitmapData: ->
        bitmapData = game.add.bitmapData @width, @height
        bitmapData.context.fillStyle = @color
        bitmapData.context.fillRect 0, 0, @width, @height
        bitmapData

    createSprite: ->
        sprite = game.add.sprite 0, 0, @createBitmapData()
        sprite.fixedToCamera = yes
        sprite.cameraOffset.x = @x
        sprite.cameraOffset.y = @y
        sprite

    isFading: ->
        0 < @sprite.alpha < 1

    show: ->
        return if @isFading()
        @sprite.alpha = 1
        @sprite.visible = yes

    hide: ->
        return if @isFading()
        @sprite.alpha = 0
        @sprite.visible = no

    fadeTo: (callback) ->
        return unless @sprite.alpha is 0
        @sprite.bringToTop()
        @sprite.visible = yes
        fade = game.add.tween @sprite
        fade.to { alpha: 1 }, @speed
        if callback
            fade.onComplete.add callback, @
        fade.start()
        @

    fadeFrom: (callback) ->
        return unless @sprite.alpha is 1
        fade = game.add.tween @sprite
        fade.to { alpha: 0 }, @speed
        fade.onComplete.add (->
            @sprite.visible = no
            if callback
                callback()
        ), @
        fade.start()
        @