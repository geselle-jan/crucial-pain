class Level

	constructor: (options = {}) ->
		@index = options.index ? 1
		@map = @createMap()
		@walls = @createWalls()
		@goal = @createGoal()

	createMap: ->
		game.add.tilemap '' + @index + ''

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

	getSpawn: (sprite) ->
		spawn = no
		data = @map.objects.entities
		for entity in data
			if entity.name is 'spawn'
				spawn = new Phaser.Point entity.x, entity.y - sprite.body.height
		unless spawn
			spawn = new Phaser.Point 0, 0
		spawn

	createGoal: ->
		goal = no
		data = @map.objects.entities
		for entity in data
			console.log entity.name
			if entity.name is 'goal'
				goal = new Goal(
					x: entity.x
					y: entity.y)
		goal

	update: ->
		for wall in @walls
			wall.update()
		@goal.update?()
		