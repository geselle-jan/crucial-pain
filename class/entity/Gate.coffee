class Gate

	bodySizes:
		n:
			base: [
				42 # width
				113 # height
				7 # x
				39 # y
			]
			center:
				top: [
					42 # width
					40 # height
					7 # x
					8 # y
				]
				bottom: [
					42 # width
					40 # height
					7 # x
					8 # y
				]
			front:  [
				42 # width
				48 # height
				7 # x
				8 # y
			]
		s:
			base: [
				42 # width
				152 # height
				7 # x
				-96 # y
			]
			center:
				top: [
					42 # width
					40 # height
					7 # x
					8 # y
				]
				bottom: [
					42 # width
					40 # height
					7 # x
					8 # y
				]
			front:  [
				42 # width
				48 # height
				7 # x
				8 # y
			]

	spritesheets:
		n:
			base: 'gate_N_base'
			center:
				top: 'gate_vert_idle1'
				bottom: 'gate_vert_idle2'
			front:'gate_N_front'
		s:
			base: 'gate_S_base'
			center:
				top: 'gate_vert_idle1'
				bottom: 'gate_vert_idle2'
			front: 'gate_S_front'
		w:
			base: 'gate_W_base'
			center:
				top:
					idle: 'gate_horiz_idle1'
					shrink: 'gate_horiz_shrink1'
				bottom:
					idle: 'gate_horiz_idle2'
					shrink: 'gate_horiz_shrink2'
			front: 'gate_W_front'
		e:
			base: 'gate_E_base'
			center:
				top:
					idle: 'gate_horiz_idle1'
					shrink: 'gate_horiz_shrink1'
				bottom:
					idle: 'gate_horiz_idle2'
					shrink: 'gate_horiz_shrink2'
			front: 'gate_E_front'

	loopFrames: [0, 1, 2]

	constructor: (options = {}) ->
		@x = options.x ? 0
		@y = options.y ? 0
		@sprites =
			n:
				center:
					top: @createSprite @x, @y - 16, @spritesheets.n.center.top, @bodySizes.n.center.top, no, yes
					bottom: @createSprite @x, @y + 24, @spritesheets.n.center.bottom, @bodySizes.n.center.bottom, no, yes
				base: @createSprite @x, @y + 40, @spritesheets.n.base, @bodySizes.n.base, yes, yes
				front: @createSprite @x, @y + 72, @spritesheets.n.front, @bodySizes.n.front, no, yes
			s:
				center:
					top: @createSprite @x, @y + 104, @spritesheets.s.center.top, @bodySizes.s.center.top, no, yes
					bottom: @createSprite @x, @y + 144, @spritesheets.s.center.bottom, @bodySizes.s.center.bottom, no, yes
				base: @createSprite @x, @y + 192, @spritesheets.s.base, @bodySizes.s.base, yes, yes
				front: @createSprite @x, @y + 72, @spritesheets.s.front, @bodySizes.s.front, no, yes
		@closedPositions =
			n:
				front:
					x: @sprites.n.front.position.x
					y: @sprites.n.front.position.y
			s:
				front:
					x: @sprites.s.front.position.x
					y: @sprites.s.front.position.y
				center:
					top:
						x: @sprites.s.center.top.position.x
						y: @sprites.s.center.top.position.y
					bottom:
						x: @sprites.s.center.bottom.position.x
						y: @sprites.s.center.bottom.position.y

	createSprite: (x, y, sheet, size, physics, loopAnimation)->
		sprite = game.add.sprite 0 - size[2], 0 - size[3], sheet
		if physics
			game.physics.enable sprite, Phaser.Physics.ARCADE
			sprite.body.immovable = yes
			sprite.body.setSize size[0], size[1], size[2], size[3]
		@moveTo x, y, sprite, size
		if loopAnimation
			@addLoopAnimation sprite
		sprite

	addLoopAnimation: (sprite) ->
		loopFPS = 10
		sprite.animations.add 'loop', @loopFrames, loopFPS, true
		sprite.animations.play 'loop'

	moveTo: (x, y, sprite, size) ->
		if size
			sprite.position.setTo x - size[2], y - size[3] - size[1]
		else
			sprite.position.setTo x, y

	setClipN: (step) ->
		baseHeight = @bodySizes.n.base[1] - 8 * 6
		stepOffset = 8 * step
		#if stepOffset > 6 * 8 then stepOffset = 6 * 8
		@sprites.n.base.body.setSize @bodySizes.n.base[0], baseHeight + stepOffset

	setClipS: (step) ->
		baseHeight = @bodySizes.s.base[1] - 8 * 10
		baseY = @bodySizes.s.base[3] + 8 * 10
		stepOffset = 8 * step
		@sprites.s.base.body.setSize @bodySizes.s.base[0], baseHeight + step * 8, @bodySizes.s.base[2], baseY - step * 8

	setClipVertical: (step) ->
		if step > 8 then step = 8
		@setClipN step
		@setClipS step

	setPositionN: (step) ->
		baseY = @closedPositions.n.front.y - 10 * 8
		@sprites.n.front.position.y = baseY + step * 8

	setCenterPositionS: (step) ->
		topWideY = @closedPositions.s.center.top.y
		topNarrowY = topWideY + 16
		bottomWideY = @closedPositions.s.center.bottom.y
		bottomNarrowY = bottomWideY + 16
		if step < 8
			@sprites.s.center.top.position.y = topNarrowY
		else
			@sprites.s.center.top.position.y = topWideY
		if step < 3
			@sprites.s.center.bottom.position.y = bottomNarrowY
		else
			@sprites.s.center.bottom.position.y = bottomWideY

	setPositionS: (step) ->
		@setCenterPositionS step
		baseY = @closedPositions.s.front.y + 10 * 8
		@sprites.s.front.position.y = baseY - step * 8

	setPositionVertical: (step) ->
		@setPositionN step
		@setPositionS step

	setCenterVisibilityN: (step) ->
		if step is 0
			@sprites.n.center.top.alpha = 0
		else
			@sprites.n.center.top.alpha = 1
		if step < 6
			@sprites.n.center.bottom.alpha = 0
		else
			@sprites.n.center.bottom.alpha = 1

	setCenterVisibilityS: (step) ->
		if step is 0
			@sprites.s.center.bottom.alpha = 0
		else
			@sprites.s.center.bottom.alpha = 1
		if step < 6
			@sprites.s.center.top.alpha = 0
		else
			@sprites.s.center.top.alpha = 1

	setCenterVisibility: (step) ->
		@setCenterVisibilityN step
		@setCenterVisibilityS step

	setVertical: (step) ->
		@setPositionVertical step
		@setClipVertical step
		@setCenterVisibility step

	openVertical: ->
		@sprites.n.center.top.alpha = 0
		@sprites.n.center.bottom.alpha = 0
		@sprites.s.center.top.alpha = 0
		@sprites.s.center.bottom.alpha = 0
		@sprites.n.front.position.y -= 80
		@sprites.s.front.position.y += 80
		@setClipVertical 0

	closeVertical: ->
		@sprites.n.center.top.alpha = 1
		@sprites.n.center.bottom.alpha = 1
		@sprites.s.center.top.alpha = 1
		@sprites.s.center.bottom.alpha = 1
		@sprites.n.front.position.y += 80
		@sprites.s.front.position.y -= 80
		@setClipVertical 10

	update: ->
		@checkForCollisions()

	checkForCollisions: ->
		if game.physics.arcade.collide game.puck.sprite, @sprites.n.base
			@onCollision()
		if game.physics.arcade.collide game.puck.sprite, @sprites.s.base
			@onCollision()

	onCollision: ->
		game.puck.ready = yes