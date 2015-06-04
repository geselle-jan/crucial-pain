class MovingWall extends Walker

	bodySize: [
		40 # width
		66 # height
		16 # x
		16 # y
	]

	spritesheet: 'movingwall'

	loopFrames: [0, 1, 2, 3, 4, 5, 6, 7]

	onCollision: ->
		game.fx.movingwall.play()