TinyRPG.Default = (game) ->

TinyRPG.Default.prototype =
    create: ->
        unless game.controls?
            game.controls = new Controls
            game.controls.create()
        game.ui ?= {}
        game.ui.foeView = new FoeView
        game.ui.fps = new FPS
        game.ui.statusInfo = new StatusInfo
        game.ui.blank = new Blank {visible: yes}
        game.ui.textbox = new TextBox
        game.ui.pauseMenu = new PauseMenu
        unless game.controls.mobile
            game.ui.crosshair = new Crosshair
        return
    update: ->
        game.controls.update()
        game.ui.foeView.update()
        game.ui.fps.update()
        game.ui.statusInfo.update()
        unless game.controls.mobile
            game.ui.crosshair.update()
        return
    render: ->