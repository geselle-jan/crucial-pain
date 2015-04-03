class Goal

	constructor: (options = {}) ->
		@x = options.x ? 0
		@y = options.y ? 0
		@bodySize = [
			40 # width
			40 # height
			30 # x
			45 # y
		]
		@sprite = @createSprite()
		@addAnimations @sprite

	createSprite: ->
		sprite = game.add.sprite 0 - @bodySize[2], 0 - @bodySize[3], 'goal'
		game.physics.enable sprite, Phaser.Physics.ARCADE
		sprite.anchor.setTo 0, 0
		sprite.body.immovable = yes
		sprite.body.setSize @bodySize[0], @bodySize[1], @bodySize[2], @bodySize[3]
		sprite.position.setTo @x - @bodySize[2], @y - @bodySize[3] - @bodySize[1]
		console.log sprite.position
		sprite

	addAnimations: (sprite) ->
		loopFPS = 10
		@sprite.animations.add 'loop', [0, 1, 2], loopFPS, true
		sprite.animations.play 'loop'

	update: ->
		@checkForCollisions()

	checkForCollisions: ->
		if game.physics.arcade.collide game.puck.sprite, @sprite
			game.puck.win()