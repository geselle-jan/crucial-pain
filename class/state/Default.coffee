CrucialPain.Default = (game) ->

CrucialPain.Default.prototype =
    create: ->
        unless game.controls?
            game.controls = new Controls
            game.controls.create()
        game.cameraManager = new CameraManager
        game.ui ?= {}
        game.ui.blank = new Blank {visible: yes}
        game.ui.fps = new FPS
        unless game.controls.mobile
            game.ui.crosshair = new Crosshair
        return
    update: ->
        game.controls.update()
        game.cameraManager.update()
        game.ui.fps.update()
        unless game.controls.mobile
            game.ui.crosshair.update()
        return
    render: ->