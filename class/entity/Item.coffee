class Item

	constructor: (options = {}) ->
		@x = options.x ? 0
		@y = options.y ? 0
		@label = options.label ? ''
		@sprite = @createSprite()
		@moveTo @x, @y
		@addAnimations()
		@addPointerEvents?()
		@addLabel?()
		@addSound()

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

	addSound: ->
		if @soundName?
			@sound = game.add.audio @soundName

	moveTo: (x, y) ->
		@sprite.position.setTo x - @bodySize[2], y - @bodySize[3] - @bodySize[1]

	update: ->
		@checkForOverlap()
		@updateSmoke()

	checkForOverlap: ->
		if game.physics.arcade.overlap game.puck.sprite, @sprite
			@onOverlap()

	kill: ->
		@createSmoke()
		@sprite.kill()
		@text?.kill()

	createSmoke: ->
		@smoke = game.add.sprite @x - @bodySize[2], @y - @bodySize[3], @smokeSpritesheet
		smokeFPS = 10
		@smoke.animations.add 'smoke', @smokeFrames, smokeFPS, false
		@smoke.animations.play 'smoke'

	updateSmoke: ->
		if @smoke?.animations?.currentAnim?.isFinished
			@smoke.kill()
			@smokeDone = yes