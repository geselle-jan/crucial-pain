class CameraManager

	constructor: (options = {}) ->
		@speed = options.speed ? 60
		@maxTime = options.maxTime ? 500
		@puckJustFound = no
		@debug = no
		@cameraPosition = game.add.sprite 0, 0, @createBitmapData()
		game.physics.enable @cameraPosition, Phaser.Physics.ARCADE

	createBitmapData: ->
		width = 1
		height = 1
		color = '#00ff00'
		bitmapData = game.add.bitmapData width, height
		bitmapData.context.fillStyle = color
		bitmapData.context.fillRect 0, 0, width, height
		bitmapData

	updatePuckCenter: ->
		puckCenter = game.puck?.sprite?.body?.center
		if puckCenter and @puckCenter
			@puckJustFound = no
			@puckCenter = puckCenter
		if puckCenter and puckCenter.x > 0 and puckCenter.y > 0 and not @puckCenter
			@puckJustFound = yes
			@puckCenter = puckCenter

	update: ->
		@updateDebug()
		@updatePuckCenter()
		@updateCameraPosition()
		@applyPositionToCamera()

	updateDebug: ->
		if @debug
			@cameraPosition.alpha = 1
		else
			@cameraPosition.alpha = 0
		

	updateCameraPosition: ->
		if @puckJustFound
			@cameraPosition.x = @puckCenter.x
			@cameraPosition.y = @puckCenter.y
		else if @puckCenter
			game.physics.arcade.moveToXY @cameraPosition, @puckCenter.x, @puckCenter.y, @speed, @maxTime

	applyPositionToCamera: ->
		game.camera.focusOnXY @cameraPosition.x, @cameraPosition.y