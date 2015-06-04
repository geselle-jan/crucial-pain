class Wall

	constructor: (options = {}) ->
		@width = options.width ? 1
		@height = options.height ? 1
		@x = options.x ? 0
		@y = options.y ? 0
		@sizes = [
			'1x1'
			'1x2'
			'1x3'
			'2x1'
			'3x1'
		]
		@bodySizes =
			'1x1': [
				42 # width
				73 # height
				15 # x
				16 # y
			]
			'1x2': [
				42 # width
				114 # height
				16 # x
				15 # y
			]
			'1x3': [
				42 # width
				154 # height
				15 # x
				15 # y
			]
			'2x1': [
				83 # width
				74 # height
				14 # x
				15 # y
			]
			'3x1': [
				122 # width
				74 # height
				16 # x
				15 # y
			]
		@sanitizeSize()
		@sprite = @createSprite()
		@addAnimations @sprite

	sanitizeSize: ->
		if @getSize() not in @sizes
			@width = 1
			@height = 1

	getSize: ->
		@width + 'x' + @height

	createSprite: ->
		sprite = game.add.sprite 0 - @bodySizes[@getSize()][2], 0 - @bodySizes[@getSize()][3], 'wall_' + @getSize()
		game.physics.enable sprite, Phaser.Physics.ARCADE
		sprite.anchor.setTo 0, 0
		sprite.body.immovable = yes
		sprite.body.setSize @bodySizes[@getSize()][0], @bodySizes[@getSize()][1], @bodySizes[@getSize()][2], @bodySizes[@getSize()][3]
		sprite.position.setTo @x - @bodySizes[@getSize()][2], @y - @bodySizes[@getSize()][3]
		sprite

	addAnimations: (sprite) ->
		loopFPS = 10
		@sprite.animations.add 'loop', [0, 1, 2], loopFPS, true
		sprite.animations.play 'loop'

	update: ->
		@checkForCollisions()

	checkForCollisions: ->
		if game.physics.arcade.collide game.puck.sprite, @sprite
			game.fx.wallhit.play()
			game.puck.damage()