class Crab

	bodySize: [
		38 # width
		38 # height
		28 # x
		39 # y
	]

	spritesheet: 'crab'

	constructor: (options = {}) ->
		@x = options.x ? 0
		@y = options.y ? 0
		@range = options.range ? 0
		@speed = options.speed ? 1
		@step = @getStep()
		@sprite = @createSprite()
		@moveTo @x, @y
		@addAnimations()

	createSprite: ->
		sprite = game.add.sprite 0 - @bodySize[2], 0 - @bodySize[3], @spritesheet
		game.physics.enable sprite, Phaser.Physics.ARCADE
		sprite.body.immovable = yes
		sprite.body.setSize @bodySize[0], @bodySize[1], @bodySize[2], @bodySize[3]
		sprite

	addAnimations: ->
		loopFPS = 10
		@sprite.animations.add 'loop', [0, 1, 2], loopFPS, true
		@sprite.animations.play 'loop'

	moveTo: (x, y) ->
		@sprite.position.setTo x - @bodySize[2], y - @bodySize[3] - @bodySize[1]

	getStep: ->
		switch
			when @range > 0 then @speed
			when @range < 0 then @speed * -1
			else 0

	update: ->
		@updateMovement()
		@checkForCollisions()

	updateMovement: ->
		newX = @sprite.body.position.x + @step
		@moveTo newX, @y
		if newX is @x + @range or newX is @x
			@changeDirection()

	changeDirection: ->
		@step = @step * -1		

	checkForCollisions: ->
		if game.physics.arcade.collide game.puck.sprite, @sprite
			game.puck.stop()
			game.puck.health = 0