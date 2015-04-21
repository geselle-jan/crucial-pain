class Button extends Item

	bodySize: [
		40 # width
		40 # height
		30 # x
		45 # y
	]

	spritesheet: 'button'

	loopFrames: [0, 1, 2]

	smokeSpritesheet: '1upsmoke'

	smokeFrames: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

	addPointerEvents: ->
		@sprite.inputEnabled = yes
		@sprite.events.onInputDown.add @onInputDown, @

	addLabel: ->
		labelOffset = [
			18 # x
			-2 # y
		]
		@text = game.add.bitmapText @x + labelOffset[0], @y + labelOffset[1] - @bodySize[1], 'astonished', @label, 36
		@text.x = @text.x - @text.width / 2
		window.test = @text

	onInputDown: ->
        game.levelIndex = @label * 1
        game.ui.blank.fadeTo ->
            game.state.clearCurrentState()
            game.state.start 'Level'

	update: ->
		@checkForOverlap()
		@updateSmoke()