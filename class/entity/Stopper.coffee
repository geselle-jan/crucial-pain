class Stopper

	bodySize: [
		39 # width
		73 # height
		17 # x
		15 # y
	]

	spritesheet: 'stopper'

	loopFrames: [0, 1, 2]

	constructor: (options = {}) ->
		@x = options.x ? 0
		@y = options.y ? 0
		@sprite = @createSprite()
		@moveTo @x, @y
		@addAnimations()
		@sound = game.add.audio 'stickywall'

	createSprite: ->
		sprite = game.add.sprite 0 - @bodySize[2], 0 - @bodySize[3], @spritesheet
		game.physics.enable sprite, Phaser.Physics.ARCADE
		sprite.body.immovable = yes
		sprite.body.setSize @bodySize[0], @bodySize[1], @bodySize[2], @bodySize[3]
		sprite

	addAnimations: ->
		loopFPS = 10
		@sprite.animations.add 'loop', @loopFrames, loopFPS, true
		@sprite.animations.play 'loop'

	moveTo: (x, y) ->
		@sprite.position.setTo x - @bodySize[2], y - @bodySize[3] - @bodySize[1]

	update: ->
		@checkForCollisions()

	checkForCollisions: ->
		if game.physics.arcade.collide game.puck.sprite, @sprite
			@onCollision()

	onCollision: ->
		game.puck.stop()
		game.puck.ready = yes
		@sound.play()