class PreloadBar

    constructor: (options = {}) ->
        @bg = options.bg ? no
        @bg = @createBg()
        @bar = options.bar ? no
        @bar = @createBar()
        @x = options.x ? 0
        @y = options.y ? 0
        @center = options.center ? no
        @vAlignCenter() if @center is 'vertical'
        @hAlignCenter() if @center is 'horizontal'
        @alignCenter() if @center is yes

    createBg: ->
        if @bg then game.add.sprite @x, @y, @bg else no
        
    createBar: ->
        if @bar then game.add.sprite @x, @y, @bar else no

    vAlignCenter: ->
        if @bg
            @bg.position.y = game.height / 2 - @bg.height / 2
        if @bar
            @bar.position.y = game.height / 2 - @bar.height / 2
        if scaleManager?
            @bg.position.y += scaleManager.levelOffsetY
            @bar.position.y += scaleManager.levelOffsetY

    hAlignCenter: ->
        if @bg
            @bg.position.x = game.width / 2 - @bg.width / 2
        if @bar
            @bar.position.x = game.width / 2 - @bar.width / 2
        if scaleManager?
            @bg.position.x += scaleManager.levelOffsetX
            @bar.position.x += scaleManager.levelOffsetX

    alignCenter: ->
        @vAlignCenter()
        @hAlignCenter()
    
    getSprite: ->
        @bar