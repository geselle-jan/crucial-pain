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
		w:
			base: [
				120 # width
				74 # height
				7 # x
				15 # ys
			]
			center:
				left: [
					40 # width
					73 # height
					8 # x
					15 # y
				]
				right: [
					40 # width
					73 # height
					8 # x
					15 # y
				]
			front:  [
				31 # width
				73 # height
				8 # x
				15 # y
			]
		e:
			base: [
				119 # width
				74 # height
				-94 # x
				15 # y
			]
			center:
				left: [
					40 # width
					73 # height
					8 # x
					15 # y
				]
				right: [
					40 # width
					73 # height
					8 # x
					15 # y
				]
			front:  [
				31 # width
				73 # height
				8 # x
				15 # y
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
				left: 'gate_horiz_idle1'
				right: 'gate_horiz_idle2'
			front: 'gate_W_front'
		e:
			base: 'gate_E_base'
			center:
				left: 'gate_horiz_idle1'
				right: 'gate_horiz_idle2'
			front: 'gate_E_front'

	loopFrames: [0, 1, 2]

	constructor: (options = {}) ->
		@x = options.x ? 0
		@y = options.y ? 0
		@timeOpened = options.timeOpened ? 0
		@timeClosed = options.timeClosed ? 0
		@orientation = options.orientation ? 'horizontal'
		if @orientation isnt 'horizontal'
			@orientation = 'vertical'
		if @orientation is 'horizontal'
			@sprites =
				w:
					center:
						left: @createSprite @x + 17, @y, @spritesheets.w.center.left, @bodySizes.w.center.left, no, yes
						right: @createSprite @x + 57, @y, @spritesheets.w.center.right, @bodySizes.w.center.right, no, yes
					base: @createSprite @x, @y + 1, @spritesheets.w.base, @bodySizes.w.base, yes, yes
					front: @createSprite @x + 97, @y, @spritesheets.w.front, @bodySizes.w.front, no, yes
				e:
					center:
						left: @createSprite @x + 142, @y, @spritesheets.e.center.left, @bodySizes.e.center.left, no, yes
						right: @createSprite @x + 182, @y, @spritesheets.e.center.right, @bodySizes.e.center.right, no, yes
					base: @createSprite @x + 120, @y + 1, @spritesheets.e.base, @bodySizes.e.base, yes, yes
					front: @createSprite @x + 111, @y, @spritesheets.e.front, @bodySizes.e.front, no, yes
			@closedPositions =
				w:
					front:
						x: @sprites.w.front.position.x
						y: @sprites.w.front.position.y
					center:
						left:
							x: @sprites.w.center.left.position.x
							y: @sprites.w.center.left.position.y
						right:
							x: @sprites.w.center.right.position.x
							y: @sprites.w.center.right.position.y
				e:
					front:
						x: @sprites.e.front.position.x
						y: @sprites.e.front.position.y
					center:
						left:
							x: @sprites.e.center.left.position.x
							y: @sprites.e.center.left.position.y
						right:
							x: @sprites.e.center.right.position.x
							y: @sprites.e.center.right.position.y
		else
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
		@opened = no
		@closed = yes
		@opening = no
		@closing = no
		@step = 10
		@openingTimer = game.time.now
		@closingTimer = game.time.now
		@openedTimer = game.time.now
		@closedTimer = game.time.now

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

	setCenterVisibilityVertical: (step) ->
		@setCenterVisibilityN step
		@setCenterVisibilityS step

	setVertical: (step) ->
		@setPositionVertical step
		@setClipVertical step
		@setCenterVisibilityVertical step

	setClipW: (step) ->
		baseWidth = @bodySizes.w.base[0] - 8 * 10
		stepOffset = 8 * step
		@sprites.w.base.body.setSize baseWidth + stepOffset, @bodySizes.w.base[1]

	setClipE: (step) ->
		baseWidth = @bodySizes.e.base[0] - 8 * 10
		baseX = @bodySizes.e.base[2] + 8 * 10
		stepOffset = 8 * step
		@sprites.e.base.body.setSize baseWidth + step * 8, @bodySizes.e.base[1], baseX - step * 8, @bodySizes.e.base[3]

	setClipHorizontal: (step) ->
		@setClipW step
		@setClipE step

	setCenterPositionW: (step) ->
		leftWideX = @closedPositions.w.center.left.x
		leftNarrowX = leftWideX - 16
		rightWideX = @closedPositions.w.center.right.x
		rightNarrowX = rightWideX - 16
		if step < 3
			@sprites.w.center.left.position.x = leftNarrowX
		else
			@sprites.w.center.left.position.x = leftWideX
		if step < 8
			@sprites.w.center.right.position.x = rightNarrowX
		else
			@sprites.w.center.right.position.x = rightWideX

	setCenterPositionE: (step) ->
		leftWideX = @closedPositions.e.center.left.x
		leftNarrowX = leftWideX + 16
		rightWideX = @closedPositions.e.center.right.x
		rightNarrowX = rightWideX + 16
		if step < 8
			@sprites.e.center.left.position.x = leftNarrowX
		else
			@sprites.e.center.left.position.x = leftWideX
		if step < 3
			@sprites.e.center.right.position.x = rightNarrowX
		else
			@sprites.e.center.right.position.x = rightWideX

	setPositionW: (step) ->
		@setCenterPositionW step
		baseX = @closedPositions.w.front.x - 10 * 8
		@sprites.w.front.position.x = baseX + step * 8

	setPositionE: (step) ->
		@setCenterPositionE step
		baseX = @closedPositions.e.front.x + 10 * 8
		@sprites.e.front.position.x = baseX - step * 8

	setPositionHorizontal: (step) ->
		@setPositionW step
		@setPositionE step

	setCenterVisibilityW: (step) ->
		if step is 0
			@sprites.w.center.left.alpha = 0
		else
			@sprites.w.center.left.alpha = 1
		if step < 6
			@sprites.w.center.right.alpha = 0
		else
			@sprites.w.center.right.alpha = 1

	setCenterVisibilityE: (step) ->
		if step is 0
			@sprites.e.center.right.alpha = 0
		else
			@sprites.e.center.right.alpha = 1
		if step < 6
			@sprites.e.center.left.alpha = 0
		else
			@sprites.e.center.left.alpha = 1

	setCenterVisibilityHorizontal: (step) ->
		@setCenterVisibilityW step
		@setCenterVisibilityE step

	setHorizontal: (step) ->
		@setPositionHorizontal step
		@setClipHorizontal step
		@setCenterVisibilityHorizontal step

	setStep: (step) ->
		if @orientation is 'horizontal'
			@setHorizontal step
		else
			@setVertical step

	update: ->
		@updateState()
		@checkForCollisions()
		@checkForOverlap()

	getMsPerFrame: (fps) ->
		1 / fps * 1000

	updateState: ->
		if @opening
			if game.time.now - @openingTimer > @getMsPerFrame 10
				@step--
				@openingTimer = game.time.now
				@setStep @step
				if @step is 0
					@opening = no
					@opened = yes
					@closed = no
					@openedTimer = game.time.now
		if @closing
			if game.time.now - @closingTimer > @getMsPerFrame 10
				@step++
				@closingTimer = game.time.now
				@setStep @step
				if @step is 10
					@closing = no
					@opened = no
					@closed = yes
					@closedTimer = game.time.now
		if @closed and not @opening
			if game.time.now - @closedTimer > @timeClosed
				@open()
		if @opened and not @closing
			if game.time.now - @openedTimer > @timeOpened
				@close()

	checkForCollisions: ->
		if @orientation is 'horizontal'
			if game.physics.arcade.collide game.puck.sprite, @sprites.w.base
				@onCollision()
			if game.physics.arcade.collide game.puck.sprite, @sprites.e.base
				@onCollision()
		else
			if game.physics.arcade.collide game.puck.sprite, @sprites.n.base
				@onCollision()
			if game.physics.arcade.collide game.puck.sprite, @sprites.s.base
				@onCollision()

	checkForOverlap: ->
		if @orientation is 'horizontal'
			if game.physics.arcade.overlap game.puck.sprite, @sprites.w.base
				@onOverlap()
			if game.physics.arcade.overlap game.puck.sprite, @sprites.e.base
				@onOverlap()
		else
			if game.physics.arcade.overlap game.puck.sprite, @sprites.n.base
				@onOverlap()
			if game.physics.arcade.overlap game.puck.sprite, @sprites.s.base
				@onOverlap()

	onCollision: ->
		game.puck.ready = yes

	onOverlap: ->
		game.puck.stop()
		game.puck.health = 0

	open: ->
		if @closed and not @closing and not @opening
			@opening = yes
			@openingTimer = game.time.now

	close: ->
		if @opened and not @closing and not @opening
			@closing = yes
			@closingTimer = game.time.now
		