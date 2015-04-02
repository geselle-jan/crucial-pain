Skeletons = (count) ->
    @count = count
    this

Skeletons::create = ->
    map = game.map
    @group = game.add.group()
    @group.enableBody = true
    i = 0
    randX = undefined
    randY = undefined
    desiredIndex = 105
    skeleton = undefined
    walkFPS = 3
    while i < @count
        randX = Helpers.GetRandom(0, map.width)
        randY = Helpers.GetRandom(0, map.height)
        if map.getTile(randX, randY) and map.getTile(randX, randY).index == desiredIndex and (randX >= 15 or randY >= 10)
            skeleton = @group.create(randX * map.tileWidth, randY * map.tileHeight, 'tiny16')
            skeleton.frame = 134
            skeleton.body.setSize 32, 32, 16, 28
            skeleton.health = 50
            skeleton.hitTimeout = false
            i++
            skeleton.animations.add 'standDown', [ 134 ], 0, false
            skeleton.animations.add 'walkDown', [
                135
                136
            ], walkFPS, true
            skeleton.animations.add 'standLeft', [ 150 ], 0, false
            skeleton.animations.add 'walkLeft', [
                151
                152
            ], walkFPS, true
            skeleton.animations.add 'standRight', [ 166 ], 0, false
            skeleton.animations.add 'walkRight', [
                167
                168
            ], walkFPS, true
            skeleton.animations.add 'standUp', [ 182 ], 0, false
            skeleton.animations.add 'walkUp', [
                183
                184
            ], walkFPS, true
            skeleton.animations.play 'standDown'
            skeleton.animations.currentAnim.timeLastChange = game.time.now - 100
    this

Skeletons::update = ->
    map = game.map
    collision = game.collision
    @group.setAll 'body.velocity.x', 0
    @group.setAll 'body.velocity.y', 0
    if game.mode == 'level'
        @group.forEach (skeleton) ->
            if skeleton.hitTimeout and game.time.now - skeleton.hitTimeout > 100
                skeleton.hitTimeout = false
                skeleton.blendMode = PIXI.blendModes.NORMAL
            if skeleton.visible and skeleton.inCamera
                line = new (Phaser.Line)(game.state.states[game.state.current].girl.player.body.center.x, game.state.states[game.state.current].girl.player.body.center.y, skeleton.body.center.x, skeleton.body.center.y)
                tileHits = undefined
                hasLineOfSight = undefined
                viewRadius = 320
                if line.length <= viewRadius
                    tileHits = collision.getRayCastTiles(line, 4, false, false)
                    hasLineOfSight = true
                    if tileHits.length > 0
                        i = 0
                        while i < tileHits.length
                            if map.collideIndexes.indexOf(tileHits[i].index) != -1
                                hasLineOfSight = false
                            i++
                    if hasLineOfSight
                        game.physics.arcade.moveToXY skeleton, game.state.states[game.state.current].girl.player.body.center.x - skeleton.body.offset.x - (skeleton.body.width / 2), game.state.states[game.state.current].girl.player.body.center.y - skeleton.body.offset.y - (skeleton.body.height / 2), Helpers.GetRandom(150, 200)
                if Helpers.GetDirectionFromVelocity(skeleton) != skeleton.animations.currentAnim.name and game.time.elapsedSince(skeleton.animations.currentAnim.timeLastChange) > 25
                    skeleton.animations.play Helpers.GetDirectionFromVelocity(skeleton, 10)
                    skeleton.animations.currentAnim.timeLastChange = game.time.now
            if skeleton.animations.paused
                skeleton.animations.paused = false
            return
        game.ui.foeView.updateGroup @group
    else
        @group.forEach (skeleton) ->
            if !skeleton.animations.paused
                skeleton.animations.paused = true
            return
    this