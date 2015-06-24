class Level

	constructor: (options = {}) ->
		@index = options.index ? 1
		@map = @createMap()
		@walls = @createWalls()
		@goal = @createGoal()
		@walkers = @createWalkers()
		@stoppers = @createStoppers()
		@oneUps = @createOneUps()
		@portals = @createPortals()
		@gates = @createGates()
		@fish = @createFish()
		@startTime = game.time.now
		@setBounds()
		@createScoreCounter()
		@done = no

	createScoreCounter: ->
		@scoreCounter = game.add.bitmapText(0, 0, 'astonished', '', 36)
		@scoreCounter.fixedToCamera = yes
		@scoreCounter.scale.set scaleManager.scale

	createMap: ->
		game.add.tilemap '' + @index + ''

	setBounds: ->
		game.world.setBounds 0, 0, @map.widthInPixels + scaleManager.levelOffsetX * 2, @map.heightInPixels + scaleManager.levelOffsetY * 2

	createWalls: ->
		walls = []
		data = @map.objects.walls
		for entry in data
			wallSize = @getWallSize entry
			wall = new Wall(
				x: entry.x + scaleManager.levelOffsetX
				y: entry.y + scaleManager.levelOffsetY
				width: wallSize.width
				height: wallSize.height)
			wall.sprite.position.y = wall.sprite.position.y - wall.sprite.body.height
			walls.push wall
		walls

	getWallSize: (data) ->
		wallInfo =
			gid1:
				width: 1
				height: 1
			gid2:
				width: 1
				height: 2
			gid3:
				width: 1
				height: 3
			gid4:
				width: 2
				height: 1
			gid5:
				width: 3
				height: 1
		wallInfo['gid' + data.gid]

	createWalkers: ->
		walkers = []
		@createWalker 'crab', Crab, walkers
		@createWalker 'hermit', Hermit, walkers
		@createWalker 'movingwall', MovingWall, walkers

	createWalker: (type, entityClass, walkers) ->
		data = @map.objects.entities
		for entity in data
			if entity.name is type
				rangeX = entity.properties?.rangeX ? 0
				rangeX = rangeX * 1
				rangeY = entity.properties?.rangeY ? 0
				rangeY = rangeY * 1
				speed = entity.properties?.speed ? 1
				speed = speed * 1
				walkers.push new entityClass(
					x: entity.x + scaleManager.levelOffsetX
					y: entity.y + scaleManager.levelOffsetY
					rangeX: rangeX
					rangeY: rangeY
					speed: speed)
		walkers

	createStoppers: ->
		stoppers = []
		data = @map.objects.entities
		for entity in data
			if entity.name is 'stopper'
				stoppers.push new Stopper(
					x: entity.x + scaleManager.levelOffsetX
					y: entity.y + scaleManager.levelOffsetY)
		stoppers

	createGates: ->
		gates = []
		data = @map.objects.entities
		for entity in data
			if entity.name is 'gateHorizontal'
				timeClosed = entity.properties?.timeClosed ? 0
				timeClosed = timeClosed * 1
				timeOpened = entity.properties?.timeOpened ? 0
				timeOpened = timeOpened * 1
				gates.push new Gate(
					x: entity.x + scaleManager.levelOffsetX
					y: entity.y + scaleManager.levelOffsetY
					timeClosed: timeClosed
					timeOpened: timeOpened
					orientation: 'horizontal')
		for entity in data
			if entity.name is 'gateVertical'
				timeClosed = entity.properties?.timeClosed ? 0
				timeClosed = timeClosed * 1
				timeOpened = entity.properties?.timeOpened ? 0
				timeOpened = timeOpened * 1
				gates.push new Gate(
					x: entity.x + scaleManager.levelOffsetX
					y: entity.y + scaleManager.levelOffsetY
					timeClosed: timeClosed
					timeOpened: timeOpened
					orientation: 'vertical')
		gates

	getSpawn: (sprite) ->
		spawn = no
		data = @map.objects.entities
		for entity in data
			if entity.name is 'spawn'
				spawn = new Phaser.Point entity.x + scaleManager.levelOffsetX, entity.y + scaleManager.levelOffsetY - sprite.body.height
		unless spawn
			spawn = new Phaser.Point 0, 0
		spawn

	createOneUps: ->
		oneUps = []
		data = @map.objects.entities
		for entity in data
			if entity.name is 'oneup'
				oneUps.push new OneUp(
					x: entity.x + scaleManager.levelOffsetX
					y: entity.y + scaleManager.levelOffsetY)
		oneUps

	createPortals: ->
		portals = []
		data = @map.objects.entities
		for entity in data
			if entity.name is 'portal'
				pid = entity.properties?.pid ? 0
				pid = pid * 1
				portals.push new Portal(
					x: entity.x + scaleManager.levelOffsetX
					y: entity.y + scaleManager.levelOffsetY
					pid: pid)
		portals

	createGoal: ->
		goal = no
		data = @map.objects.entities
		for entity in data
			if entity.name is 'goal'
				goal = new Goal(
					x: entity.x + scaleManager.levelOffsetX
					y: entity.y + scaleManager.levelOffsetY)
		goal

	createFish: ->
		content = @tutorial['level'+@index+'']
		fish = no
		if content
			fish = new Fish(
				x: 50 * scaleManager.scale
				y: 0,
				content: content)
		fish

	update: ->
		for wall in @walls
			wall.update()
		for walker in @walkers
			walker.update()
		for stopper in @stoppers
			stopper.update()
		for oneUp in @oneUps
			oneUp.update()
		for portal in @portals
			portal.update()
		for gate in @gates
			gate.update()
		@goal.update?()
		@fish.update?()
		if @goal.reached and not @done
			@win()
		@updateScoreCounter()

	updateScoreCounter: ->
		@scoreCounter.cameraOffset.x = 32
		@scoreCounter.cameraOffset.y = game.camera.height - 32 - 32 * scaleManager.scale
		unless @done
			scoreText = Helpers.ScoreToString game.time.now - @startTime
		else
			scoreText = Helpers.ScoreToString @levelScore
			if @newHighscore
				scoreText += ' new highscore'
		@scoreCounter.setText scoreText
		
	win: ->
		@endTime = game.time.now
		@levelScore = @endTime - @startTime
		window.analytics?.trackEvent 'Level', 'Level ' + @index, 'Win', @levelScore / 1000
		maxLevelScore = localStorage.getItem 'maxLevelScore' + @index + ''
		if maxLevelScore
			maxLevelScore = maxLevelScore * 1
			unless maxLevelScore <= @levelScore
				localStorage.setItem 'maxLevelScore' + @index + '', @levelScore
				@newHighscore = yes
		else
			localStorage.setItem 'maxLevelScore' + @index + '', @levelScore
			@newHighscore = yes
		@done = yes

	tutorial:
		level1: 'Tap where you want to move to.\nThe further away you tap, the faster you go.\nReach the pink face to get to the next level.'
		level2: 'This is an enemy.\nIf you touch it you die.\nSo don\'t.'
		level3: 'When you move, you won\'t be able\nto move again until you hit a wall.\nWhen you can move, your puck will be brighter.'
		level4: 'The pink star is a portal.\nIt will take you to its counterpart.\nYour speed and direction will be preserved.'
		level5: 'This is a gate. Gates open and close\nautomatically. If you are inside a gate\nwhile its closing, you die.'
		level6: 'The orange blocks are sponges.\nThey make you stop and let you move again.'
		level7: 'The yellow blocks are walking walls.\nBe careful, they won\'t enable you to move again.'
		level8: 'You have 3 lifes. When you hit a wall you loose\na life but will able to move again.'
		level9: 'The item in this level lets you regain a life.\nKeep your eyes open for these.\nGood luck!'

























