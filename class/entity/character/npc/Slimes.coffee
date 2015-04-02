Slimes = (count) ->
    @count = count
    @paused = false
    this

Slimes::create = ->
    map = game.map
    @group = game.add.group()
    @group.enableBody = true
    i = 0
    randX = undefined
    randY = undefined
    desiredIndex = 105
    slime = undefined
    walkFPS = 4
    while i < @count
        randX = Helpers.GetRandom(0, map.width)
        randY = Helpers.GetRandom(0, map.height)
        if map.getTile(randX, randY) and map.getTile(randX, randY).index == desiredIndex and (randX >= 15 or randY >= 10)
            slime = @group.create(randX * map.tileWidth, randY * map.tileHeight, 'tiny16')
            slime.frame = 192
            slime.body.setSize 40, 44, 12, 16
            slime.health = 30
            i++
            slime.animations.add 'standDown', [ 192 ], 0, false
            slime.animations.add 'walkDown', [
                193
                194
            ], walkFPS, true
            slime.animations.add 'standLeft', [ 208 ], 0, false
            slime.animations.add 'walkLeft', [
                209
                210
            ], walkFPS, true
            slime.animations.add 'standRight', [ 224 ], 0, false
            slime.animations.add 'walkRight', [
                225
                226
            ], walkFPS, true
            slime.animations.add 'standUp', [ 240 ], 0, false
            slime.animations.add 'walkUp', [
                241
                242
            ], walkFPS, true
            slime.animations.play 'standDown'
            slime.animations.currentAnim.timeLastChange = game.time.now - 100
    this

Slimes::update = ->
    if game.mode == 'level'
        if !@paused
            @group.forEach (slime) ->
                if slime.hitTimeout and game.time.now - slime.hitTimeout > 100
                    slime.hitTimeout = false
                    slime.blendMode = PIXI.blendModes.NORMAL
                if slime.visible and slime.inCamera
                    if slime.body.velocity.x == 0 and slime.body.velocity.y == 0
                        slime.body.velocity.x = Helpers.GetRandom(-80, 80)
                        slime.body.velocity.y = Helpers.GetRandom(-80, 80)
                    else
                        slime.body.velocity.x = (Helpers.GetRandom(-800, 800) + slime.body.velocity.x * 120) / 121
                        slime.body.velocity.y = (Helpers.GetRandom(-800, 800) + slime.body.velocity.y * 120) / 121
                    if Helpers.GetDirectionFromVelocity(slime) != slime.animations.currentAnim.name and game.time.elapsedSince(slime.animations.currentAnim.timeLastChange) > 1000
                        slime.animations.play Helpers.GetDirectionFromVelocity(slime, 10)
                        slime.animations.currentAnim.timeLastChange = game.time.now
                return
            game.ui.foeView.updateGroup @group
        else
            @group.forEach (slime) ->
                slime.body.velocity = slime.body.savedVelocity
                if slime.animations.paused
                    slime.animations.paused = false
                return
            @paused = false
    else if !@paused
        @group.forEach (slime) ->
            slime.body.savedVelocity = slime.body.velocity
            slime.body.velocity.x = 0
            slime.body.velocity.y = 0
            if !slime.animations.paused
                slime.animations.paused = true
            return
        @paused = true
    this