class Walker

	constructor: (options = {}) ->
		@x = options.x ? 0
		@y = options.y ? 0
		@rangeX = options.rangeX ? 0
		@rangeY = options.rangeY ? 0
		@speed = options.speed ? 1
		@stepX = @getStepX()
		@stepY = @getStepY()
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
		@sprite.animations.add 'loop', @loopFrames, loopFPS, true
		@sprite.animations.play 'loop'

	moveTo: (x, y) ->
		@sprite.position.setTo x - @bodySize[2], y - @bodySize[3] - @bodySize[1]

	getStepX: ->
		switch
			when @rangeX > 0 then @speed
			when @rangeX < 0 then @speed * -1
			else 0

	getStepY: ->
		switch
			when @rangeY > 0 then @speed
			when @rangeY < 0 then @speed * -1
			else 0

	update: ->
		@updateMovement()
		@checkForCollisions()
		@checkForOverlap()

	updateMovement: ->
		newX = @sprite.body.position.x + @stepX
		newY = @sprite.body.position.y + @stepY + @bodySize[1]
		@moveTo newX, newY
		if newX is @x + @rangeX or newX is @x
			@changeDirectionX()
		if newY is @y + @rangeY or newY is @y
			@changeDirectionY()

	changeDirectionX: ->
		@stepX = @stepX * -1

	changeDirectionY: ->
		@stepY = @stepY * -1

	checkForCollisions: ->
		if game.physics.arcade.collide game.puck.sprite, @sprite
			@onCollision?()

	checkForOverlap: ->
		if game.physics.arcade.overlap game.puck.sprite, @sprite
			@onOverlap?()