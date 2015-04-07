class Level

	constructor: (options = {}) ->
		@index = options.index ? 1
		@map = @createMap()
		@setBounds()
		@walls = @createWalls()
		@goal = @createGoal()
		@walkers = @createWalkers()
		@stoppers = @createStoppers()
		@oneUps = @createOneUps()
		@portals = @createPortals()
		@gates = @createGates()

	createMap: ->
		game.add.tilemap '' + @index + ''

	setBounds: ->
		game.world.setBounds 0,0, @map.widthInPixels, @map.heightInPixels

	createWalls: ->
		walls = []
		data = @map.objects.walls
		for entry in data
			wallSize = @getWallSize entry
			wall = new Wall(
				x: entry.x
				y: entry.y
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
					x: entity.x
					y: entity.y
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
					x: entity.x
					y: entity.y)
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
					x: entity.x
					y: entity.y
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
					x: entity.x
					y: entity.y
					timeClosed: timeClosed
					timeOpened: timeOpened
					orientation: 'vertical')
		gates

	getSpawn: (sprite) ->
		spawn = no
		data = @map.objects.entities
		for entity in data
			if entity.name is 'spawn'
				spawn = new Phaser.Point entity.x, entity.y - sprite.body.height
		unless spawn
			spawn = new Phaser.Point 0, 0
		spawn

	createOneUps: ->
		oneUps = []
		data = @map.objects.entities
		for entity in data
			if entity.name is 'oneup'
				oneUps.push new OneUp(
					x: entity.x
					y: entity.y)
		oneUps

	createPortals: ->
		portals = []
		data = @map.objects.entities
		for entity in data
			if entity.name is 'portal'
				pid = entity.properties?.pid ? 0
				pid = pid * 1
				portals.push new Portal(
					x: entity.x
					y: entity.y
					pid: pid)
		portals

	createGoal: ->
		goal = no
		data = @map.objects.entities
		for entity in data
			if entity.name is 'goal'
				goal = new Goal(
					x: entity.x
					y: entity.y)
		goal

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
		