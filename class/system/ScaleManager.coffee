class ScaleManager

	constructor: (options = {}) ->
		@width = options.width ? 1024
		@height = options.height ? 768
		@ratio = @width / @height
		@window = $ window
		@windowWidth = @window.width()
		@windowHeight = @window.height()
		@windowRatio = @windowWidth / @windowHeight
		@windowScaleY = @windowHeight / @height
		@windowScaleX = @windowWidth / @width
		if @ratio > @windowRatio
			@overflow = 'y'
		else
			@overflow = 'x'
		@calculateGameSize()

	calculateGameSize: ->
		if @overflow is 'x'
			@calculateGameSizeX()
		else
			@calculateGameSizeY()

	calculateGameSizeX: ->
		scaledWidth = @width * @windowScaleY
		scaledOffsetX = @windowWidth - scaledWidth
		realOffsetX = scaledOffsetX / @windowScaleY
		@gameWidth = @width + realOffsetX
		@gameHeight = @height
		@levelOffsetX = realOffsetX / 2
		@levelOffsetY = 0

	calculateGameSizeY: ->
		scaledHeight = @height * @windowScaleX
		scaledOffsetY = @windowHeight - scaledHeight
		realOffsetY = scaledOffsetY / @windowScaleX
		@gameHeight = @height + realOffsetY
		@gameWidth = @width
		@levelOffsetX = 0
		@levelOffsetY = realOffsetY / 2