CrucialPain.Default = (game) ->

CrucialPain.Default.prototype =
    create: ->
        unless game.controls?
            game.controls = new Controls
            game.controls.create()
        game.ui ?= {}
        game.ui.fps = new FPS
        game.ui.blank = new Blank {visible: yes}
        unless game.controls.mobile
            game.ui.crosshair = new Crosshair
        return
    update: ->
        game.controls.update()
        game.ui.fps.update()
        unless game.controls.mobile
            game.ui.crosshair.update()
        return
    render: ->