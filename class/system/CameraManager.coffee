class CameraManager

	constructor: (options = {}) ->
		@lerp = options.lerp ? 0.1 # 1 is lock on, lower is smoother
		@cameraPosition = new Phaser.Point 0, 0

	registerPlayer: (player) ->
		@player = player
		@playerPosition = @player?.sprite?.body?.center

	update: ->
		if @playerPosition
			@updateCameraPosition()
			@applyPositionToCamera()

	updatePosition: ->
		@cameraPosition.x += (@playerPosition.x - @cameraPosition.x) * @lerp
		@cameraPosition.y += (@playerPosition.y - @cameraPosition.y) * @lerp

	applyPositionToCamera: ->
		game.camera.focusOnXY @cameraPosition.x, @cameraPosition.y