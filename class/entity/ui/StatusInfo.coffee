class StatusInfo

    barData:
        health:
            color: '#D04648'
            x: 39
            y: 155
        mana:
            color: '#597DCE'
            x: 111
            y: 155
        xp:
            color: '#6CAA2C'
            x: 183
            y: 155

    constructor: (options = {}) ->
        @scale = 4
        @background = @createBackground()
        @createBars()
        @currentWeapon = @createCurrentWeapon()

    createBackground: ->
        background = game.add.sprite 0, 0, 'statusinfo'
        background.scale.setTo @scale
        background.fixedToCamera = yes
        background.cameraOffset.x = 0
        background.cameraOffset.y = game.camera.height - background.height
        background.visible = no
        background

    createCurrentWeapon: ->
        currentWeapon = game.add.sprite 0, 0, 'tiny16'
        currentWeapon.fixedToCamera = yes
        currentWeapon.cameraOffset.x = 2 * @scale
        currentWeapon.cameraOffset.y = 142 * @scale
        currentWeapon.visible = yes
        currentWeapon

    createBarBitmapData: (color, width, height) ->
        bitmapData = game.add.bitmapData width, height
        bitmapData.context.fillStyle = color
        bitmapData.context.fillRect 0, 0, width, height
        bitmapData

    createBar: (name, color, x, y) ->
        bar = @[name + 'bar'] = game.add.sprite 0, 0, @createBarBitmapData color, 50, 3
        bar.scale.setTo @scale
        bar.fixedToCamera = yes
        bar.cameraOffset.x = x * @scale
        bar.cameraOffset.y = y * @scale
        bar.visible = no
        bar

    createBars: ->
        for name, params of @barData
            @createBar name, params.color, params.x, params.y

    show: ->
        @background.visible = yes
        @healthbar.visible = yes
        @manabar.visible = yes
        @xpbar.visible = yes
        @currentWeapon.visible = yes
        @

    hide: ->
        @background.visible = no
        @healthbar.visible = no
        @manabar.visible = no
        @xpbar.visible = no
        @currentWeapon.visible = no
        @

    updateBarLengths: ->
        @healthbar.width = Math.ceil(game.player.health / 2) * @scale
        @manabar.width = Math.ceil(game.player.mana / 2) * @scale
        @xpbar.width = Math.ceil(game.player.xp / 2) * @scale
        @

    updateCurrentWeapon: ->
        @currentWeapon.frame = game.player.activeWeapon.iconFrame
        @

    update: ->
        state = game.state.states[game.state.current]
        if state.girl? and game.player?.health?
            @show()
            @updateBarLengths()
            @updateCurrentWeapon()
        else
            @hide()
        @