class CameraManager

	constructor: (options = {}) ->
		@lerp = options.lerp ? 0.1 # 1 is lock on, lower is smoother
		@cameraPosition = new Phaser.Point 0, 0

	update: ->
		playerPosition = game.puck?.sprite.body.center
		if playerPosition
			@updateCameraPosition playerPosition
			@applyPositionToCamera()

	updateCameraPosition: (playerPosition) ->
		@cameraPosition.x += (playerPosition.x - @cameraPosition.x) * @lerp
		@cameraPosition.y += (playerPosition.y - @cameraPosition.y) * @lerp

	applyPositionToCamera: ->
		game.camera.focusOnXY @cameraPosition.x, @cameraPosition.y