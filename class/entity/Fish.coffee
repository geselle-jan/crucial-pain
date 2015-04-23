class Fish

	constructor: (options = {}) ->
		@x = options.x ? 0
		@y = options.y ? 0
		@content = options.content ? 0
		@sprite = @createSprite()
		@text = @createText()
		@addAnimations()

	createSprite: ->
		sprite = game.add.sprite 0, 0, 'fish'
		sprite.fixedToCamera = yes
		sprite.cameraOffset.x = @x
		sprite.cameraOffset.y = @y
		sprite

	createText: ->
		text = game.add.bitmapText(0, 0, 'astonished', @content, 36)
		text.fixedToCamera = yes
		text.cameraOffset.x = @x + 185
		text.cameraOffset.y = @y + 16
		window.text = text
		text

	addAnimations: ->
		loopFPS = 10
		@sprite.animations.add 'loop', [0, 1, 2, 3, 4, 5, 6, 7], loopFPS, true
		@sprite.animations.play 'loop'

	update: ->