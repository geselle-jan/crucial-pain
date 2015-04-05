class Portal extends Item

	bodySize: [
		40 # width
		40 # height
		30 # x
		45 # y
	]

	spritesheet: 'portal'

	loopFrames: [0, 1, 2]

	smokeSpritesheet: 'portalsmoke'

	smokeFrames: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

	constructor: (options = {}) ->
		@pid = options.pid ? 1
		super options

	onOverlap: ->
		@kill()
		target = @getTarget()
		deltaX = target.sprite.position.x - @sprite.position.x
		deltaY = target.sprite.position.y - @sprite.position.y
		target.kill()
		game.puck.sprite.position.x += deltaX
		game.puck.sprite.position.y += deltaY

	getTarget: ->
		target
		for portal in game.level.portals
			target = portal if portal.pid is @pid and portal isnt @
		target
			
		