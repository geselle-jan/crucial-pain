class OneUp extends Item

	bodySize: [
		40 # width
		40 # height
		30 # x
		45 # y
	]

	spritesheet: '1up'

	loopFrames: [0, 1, 2]

	smokeSpritesheet: '1upsmoke'

	smokeFrames: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

	soundName: 'oneup'

	onOverlap: ->
		@kill()
		@sound.play()
		if game.puck.health < 3 then game.puck.health++