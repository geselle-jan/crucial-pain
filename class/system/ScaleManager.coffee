class ScaleManager

	devices:
		iPadMini:
			deviceWidth: 1024
			deviceHeight: 768
			scale: 1
		iPhone6Plus:
			deviceWidth: 736
			deviceHeight: 414
			scale: 1.25
		iPhone6:
			deviceWidth: 667
			deviceHeight: 375
			scale: 1.5
		iPhone5:
			deviceWidth: 568
			deviceHeight: 320
			scale: 1.55
		iPhone4:
			deviceWidth: 480
			deviceHeight: 320
			scale: 1.55

	constructor: (options = {}) ->
		@width = options.width ? 1024
		@height = options.height ? 768
		@window = $ window
		@windowWidth = @window.width()
		@windowHeight = @window.height()
		@calculateSafeZone()
		@ratio = @width / @height
		@windowRatio = @windowWidth / @windowHeight
		@windowScaleY = @windowHeight / @height
		@windowScaleX = @windowWidth / @width
		if @ratio > @windowRatio
			@overflow = 'y'
		else
			@overflow = 'x'
		@calculateGameSize()

	calculateSafeZone: ->
		device = no
		for name, data of @devices
			if data.deviceHeight >= @windowHeight and data.deviceWidth >= @windowWidth
				device = data
		unless device
			device = @devices.iPadMini
		@width = @width / device.scale
		@height = @height / device.scale
		@scale = device.scale
		

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