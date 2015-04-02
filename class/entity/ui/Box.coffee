class Box

    constructor: (options = {}) ->
        @color = options.color ? '#597dce'
        @width = options.width ? 16
        @height = options.height ? 16
        @x = options.x ? 0
        @y = options.y ? 0
        @scale = options.scale ? 4
        @asset = 'boxborder'
        @sprite = @createSprite()

    createCorners: ->
        topLeft: new Phaser.Rectangle 0, 0, 5, 5
        topRight: new Phaser.Rectangle 4, 0, 5, 5
        bottomRight: new Phaser.Rectangle 4, 4, 5, 5
        bottomLeft: new Phaser.Rectangle 0, 4, 5, 5

    renderBackground: (bitmapData) ->
        bitmapData.context.fillRect 5, 5, @width - 10, @height - 10
        bitmapData

    renderCorners: (bitmapData) ->
        c = @createCorners()
        bitmapData.copyRect @asset, c.topLeft, 0, 0
        bitmapData.copyRect @asset, c.topRight, @width - 5, 0
        bitmapData.copyRect @asset, c.bottomRight, @width - 5, @height - 5
        bitmapData.copyRect @asset, c.bottomLeft, 0, @height - 5
        bitmapData

    renderBorders: (bitmapData) ->
        bitmapData.copy @asset, 4, 0, 1, 5, 5, 0, @width - 10, 5
        bitmapData.copy @asset, 4, 4, 1, 5, 5, @height - 5, @width - 10, 5
        bitmapData.copy @asset, 0, 4, 5, 1, 0, 5, 5, @height - 10
        bitmapData.copy @asset, 4, 4, 5, 1, @width - 5, 5, 5, @height - 10
        bitmapData

    createBitmapData: ->
        bitmapData = game.add.bitmapData @width, @height
        bitmapData.context.fillStyle = @color
        @renderBackground bitmapData
        @renderCorners bitmapData
        @renderBorders bitmapData
        bitmapData

    createSprite: ->
        bmd = @createBitmapData()
        sprite = game.add.sprite 0, 0, bmd
        sprite.scale.setTo @scale
        sprite.fixedToCamera = yes
        sprite.cameraOffset.x = @x
        sprite.cameraOffset.y = @y
        sprite







