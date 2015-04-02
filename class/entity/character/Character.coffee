class Character
	constructor: (options = {}) ->
		@scale = 4
		@paused = no
		@animations = []
		@health = 100
		@hitTimeout = no
		@bodySize =
			width: 32
			height: 32
			x: -16
			y: 0

	addAnimations: ->
		for animation in @animations
			@sprite.animations.add animation