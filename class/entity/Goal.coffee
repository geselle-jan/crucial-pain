class Goal extends Item

	reached: no

	bodySize: [
		40 # width
		40 # height
		30 # x
		45 # y
	]

	spritesheet: 'goal'

	loopFrames: [0, 1, 2]

	smokeSpritesheet: 'goalsmoke'

	smokeFrames: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

	soundName: 'goal'

	onOverlap: ->
		@kill()
		game.puck.stop()
		@reached = yes
		@sound.play()

	isReached: ->
		@smokeDone and @reached