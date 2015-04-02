TinyRPG.Town = (game) ->

TinyRPG.Town.prototype =
    create: ->
        game.mode = 'level'
        game.physics.startSystem Phaser.Physics.ARCADE
        game.stage.setBackgroundColor '#17091C'
        @map = game.add.tilemap('town')
        @map.addTilesetImage 'tiny16'
        @map.addTilesetImage 'collision'
        @map.setCollision [ 1 ]
        @collision = @map.createLayer('collision')
        @collision.resizeWorld()
        @collision.visible = false
        @map.createLayer 'deco3'
        @map.createLayer 'deco2'
        @map.createLayer 'deco1'
        @map.createLayer 'deco0'
        @girl = new Girl
        @girl.create()
        @stateChange = false
        @waterTimer = 0
        @fireplaceTimer = 0
        @torchTimer = 0
        game.input.onDown.add (->
            e = undefined
            x = undefined
            y = undefined
            tile = undefined
            line = undefined
            if game.mode == 'level'
                i = @events.length - 1
                while i >= 0
                    e = @events[i]
                    if e.trigger.type == 'onTileClick'
                        x = Math.floor(game.input.worldX / 64)
                        y = Math.floor(game.input.worldY / 64)
                        if e.trigger.location.x == x and e.trigger.location.y == y
                            if typeof e.trigger.layer != 'undefined'
                                tile = game.state.states[game.state.current].map.getTile(x, y, e.trigger.layer)
                            if typeof e.trigger.maxDistance != 'undefined'
                                line = new (Phaser.Line)(@girl.player.x - (@girl.player.width / 2), @girl.player.y - (@girl.player.height / 2), x * 64 + 32, y * 64 + 32)
                            if (typeof e.trigger.layer == 'undefined' or tile.index == e.trigger.index) and (typeof e.trigger.maxDistance == 'undefined' or line.length <= e.trigger.maxDistance)
                                # event shall be dispatched
                                if e.action.type == 'textbox'
                                    game.ui.textbox.show e.action.text
                                # event finished dispatching
                    i--
            return
        ), this
        game.state.states.Default.create()
        game.ui.blank.fadeFrom()
        return
    update: ->
        that = this
        game.state.states.Default.update()
        game.ui.crosshair.update()
        @girl.update()
        if game.mode == 'level'
            if @torchTimer == 0
                @map.swap 214, 213, undefined, undefined, undefined, undefined, 'deco2'
                @torchTimer = 64
            else if @torchTimer == 16
                @map.swap 213, 214, undefined, undefined, undefined, undefined, 'deco2'
            else if @torchTimer == 32
                @map.swap 214, 215, undefined, undefined, undefined, undefined, 'deco2'
            else if @torchTimer == 48
                @map.swap 215, 214, undefined, undefined, undefined, undefined, 'deco2'
            @torchTimer--
            if @fireplaceTimer == 0
                @map.swap 89, 88, undefined, undefined, undefined, undefined, 'deco3'
                @fireplaceTimer = 64
            else if @fireplaceTimer == 16
                @map.swap 88, 89, undefined, undefined, undefined, undefined, 'deco3'
            else if @fireplaceTimer == 32
                @map.swap 89, 90, undefined, undefined, undefined, undefined, 'deco3'
            else if @fireplaceTimer == 48
                @map.swap 90, 89, undefined, undefined, undefined, undefined, 'deco3'
            @fireplaceTimer--
            if @waterTimer == 0
                @map.swap 134, 135, undefined, undefined, undefined, undefined, 'deco2'
                @waterTimer = 60
            @waterTimer--
        if @stateChange
            @stateChange()
        game.physics.arcade.collide @girl.player, @collision, (a1, a2) ->
            if a2.x == 42 and a2.y == 43

                that.stateChange = ->
                    game.mode = 'stateChange'
                    game.ui.blank.fadeTo ->
                        game.state.start 'Dungeon', true
                        game.state.clearCurrentState()
                    return

            return
        game.physics.arcade.overlap @girl.bullets, @collision, (shot) ->
            shot.kill()
            return
        return
    render: ->

        ###
        game.debug.body(girl.player);
        for (var i = skeletons.children.length - 1; i >= 0; i--) {
                game.debug.body(skeletons.children[i]);
        };
        var bullets = game.state.states[game.state.current].girl.bullets;
        for (var i = bullets.children.length - 1; i >= 0; i--) {
                if (bullets.children[i].alive) {
                        game.debug.body(bullets.children[i]);
                }
        };
        ###

        return
    events: [
        {
            name: 'home_sign'
            trigger:
                type: 'onTileClick'
                location:
                    x: 33
                    y: 34
                maxDistance: 127
                layer: 'deco2'
                index: 97
            action:
                type: 'textbox'
                text: 'You stand in front of your house\nreading your own address.\n\nWhat a pointless waste of time...'
        }
        {
            name: 'dungeon_sign'
            trigger:
                type: 'onTileClick'
                location:
                    x: 43
                    y: 45
                maxDistance: 127
                layer: 'deco2'
                index: 97
            action:
                type: 'textbox'
                text: 'Evil Dungeon of Eternal Darkness'
        }
        {
            name: 'townhall_sign'
            trigger:
                type: 'onTileClick'
                location:
                    x: 16
                    y: 20
                maxDistance: 127
                layer: 'deco2'
                index: 97
            action:
                type: 'textbox'
                text: 'Town Hall'
        }
        {
            name: 'shop_sign'
            trigger:
                type: 'onTileClick'
                location:
                    x: 17
                    y: 31
                maxDistance: 127
                layer: 'deco2'
                index: 97
            action:
                type: 'textbox'
                text: 'Shop'
        }
        {
            name: 'lodging_sign'
            trigger:
                type: 'onTileClick'
                location:
                    x: 13
                    y: 39
                maxDistance: 127
                layer: 'deco2'
                index: 97
            action:
                type: 'textbox'
                text: 'Night\'s Lodging'
        }
        {
            name: 'shop_dialog'
            trigger:
                type: 'onTileClick'
                location:
                    x: 15
                    y: 26
                maxDistance: 127
                layer: 'deco0'
                index: 136
            action:
                type: 'textbox'
                text: 'His cold dead eyes are staring at you.\nHe doesn\'t say a word.'
        }
    ]