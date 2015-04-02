class Crosshair

    constructor: (options = {}) ->
        @color = options.color ? '#ffffff'
        @width = options.width ? 1
        @height = options.height ? 1
        @scale = options.scale ? 1
        @showHelper = no
        @x = 0
        @y = 0
        @previousPrimary = no
        @offset =
            x: 14
            y: 14
        @sprite = @createSprite()
        if @showHelper
            @helper = @createHelper()

    createBitmapData: ->
        bitmapData = game.add.bitmapData @width, @height
        bitmapData.context.fillStyle = @color
        bitmapData.context.fillRect 0, 0, @width, @height
        bitmapData

    createHelper: ->
        bmd = @createBitmapData()
        sprite = game.add.sprite @x, @y, bmd
        sprite.scale.setTo @scale
        game.physics.enable sprite
        sprite.anchor.setTo 0.5
        sprite.fixedToCamera = yes
        sprite

    createSprite: ->
        sprite = game.add.sprite @x + @offset.x, @y + @offset.y, 'cursor'
        sprite.scale.setTo @scale
        game.physics.enable sprite
        sprite.anchor.setTo 0.5
        sprite.fixedToCamera = yes
        sprite.animations.add 'loop', [
            0
            1
            2
        ], 10, true
        sprite.animations.add 'click', [
            3
            4
            5
            6
            5
            4
            3
        ], 40, false
        sprite.animations.play 'loop'
        sprite

    update: ->
        down = no
        up = no
        if game.controls.primary and not @previousPrimary
            down = yes
        if @previousPrimary and not game.controls.primary
            up = yes
        @previousPrimary = game.controls.primary
        currentAnim = @sprite.animations.currentAnim.name
        animDone = @sprite.animations.currentAnim.isFinished
        if down and currentAnim isnt 'click'
            @sprite.animations.play 'click'
        if currentAnim is 'click' and animDone
            @sprite.animations.play 'loop'
        @x = game.controls.worldX
        @x = if @x then @x else 0
        @y = game.controls.worldY
        @y = if @y then @y else 0
        if @showHelper
            @helper.cameraOffset.setTo @x - game.camera.x, @y - game.camera.y
        @sprite.cameraOffset.setTo @x - game.camera.x + @offset.x, @y - game.camera.y + @offset.y
        @