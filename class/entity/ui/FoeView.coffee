class FoeView

    constructor: (options = {}) ->
        @width = options.width ? 2
        @height = options.height ? 2
        @scale = options.scale ? 4
        @maxFoes = options.maxFoes ? 100
        @foeMarkers = @createFoeMarkers()
        @state = game.state.states[game.state.current]
        @player = @state.girl?.player

    createFoeMarkers: ->
        markers = game.add.group()
        markers.createMultiple @maxFoes, 'foemarker'
        markers.setAll 'anchor.x', 0.5
        markers.setAll 'anchor.y', 0.5
        markers.setAll 'scale.x', @scale
        markers.setAll 'scale.y', @scale
        markers.setAll 'fixedToCamera', yes
        markers

    update: ->
        if game.mode is 'level'
            @foeMarkers.forEachAlive ((foeMarker) ->
                foeMarker.kill()
            ), @
        @

    getInterfaceCorners: ->
        c = game.camera
        topLeft:
            x: c.x
            y: c.y
        topRight:
            x: c.x + c.width
            y: c.y
        bottomLeftOne:
            x: c.x + 20 * @scale
            y: c.y + c.height - 7 * @scale
        bottomLeftTwo:
            x: c.x + 20 * @scale
            y: c.y + c.height - 20 * @scale
        bottomLeftThree:
            x: c.x
            y: c.y + c.height - 20 * @scale
        bottomRight:
            x: c.x + c.width
            y: c.y + c.height - 7 * @scale

    getInterfaceBorders: ->
        i = @getInterfaceCorners()
        [
            new (Phaser.Line)(i.topLeft.x, i.topLeft.y, i.topRight.x, i.topRight.y)
            new (Phaser.Line)(i.topRight.x, i.topRight.y, i.bottomRight.x, i.bottomRight.y)
            new (Phaser.Line)(i.bottomRight.x, i.bottomRight.y, i.bottomLeftOne.x, i.bottomLeftOne.y)
            new (Phaser.Line)(i.bottomLeftOne.x, i.bottomLeftOne.y, i.bottomLeftTwo.x, i.bottomLeftTwo.y)
            new (Phaser.Line)(i.bottomLeftTwo.x, i.bottomLeftTwo.y, i.bottomLeftThree.x, i.bottomLeftThree.y)
            new (Phaser.Line)(i.bottomLeftThree.x, i.bottomLeftThree.y, i.topLeft.x, i.topLeft.y)
        ]

    getLineOfSight: (foe)->
        p = @player.body.center
        f = foe.body.center
        new Phaser.Line p.x, p.y, f.x, f.y

    updateGroup: (group) ->
        if game.controls.f.isDown and game.mode == 'level'
            borders = @getInterfaceBorders()
            group.forEachAlive ((foe) ->
                if @foeMarkers.countDead() > 0
                    lineOfSight = @getLineOfSight foe
                    for border in borders
                        temp = lineOfSight.intersects(border)
                        intersection = if temp then temp else intersection
                    if intersection
                        foeMarker = @foeMarkers.getFirstDead()
                        foeMarker.reset()
                        foeMarker.cameraOffset.x = intersection.x - game.camera.x
                        foeMarker.cameraOffset.y = intersection.y - game.camera.y
                return
            ), @
        @