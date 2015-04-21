CrucialPain.Default = (game) ->

CrucialPain.Default.prototype =
    create: ->
        unless game.controls?
            game.controls = new Controls
            game.controls.create()
        game.cameraManager = new CameraManager
        game.ui ?= {}
        game.ui.blank = new Blank {visible: yes}
        unless game.controls.mobile
            game.ui.fps = new FPS
            game.ui.crosshair = new Crosshair
        return
    update: ->
        game.controls.update()
        game.cameraManager.update()
        unless game.controls.mobile
            game.ui.fps.update()
            game.ui.crosshair.update()
        return
    render: ->