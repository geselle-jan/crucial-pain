class FX

    constructor: ->
        @wallhit = game.add.audio 'wallhit'
        @goal = game.add.audio 'goal'
        @portal = game.add.audio 'portal'
        @stickywall = game.add.audio 'stickywall'
        @movingwall = game.add.audio 'movingwall'
        @oneup = game.add.audio 'oneup'
        @enemy = game.add.audio 'enemy'
        @death = game.add.audio 'death'
        @setVolumes()

    setVolumes: ->
        @wallhit.volume    = game.volume.fx - 0.2
        @goal.volume       = game.volume.fx + 0
        @portal.volume     = game.volume.fx + 0
        @stickywall.volume = game.volume.fx + 0
        @movingwall.volume = game.volume.fx - 0.5
        @oneup.volume      = game.volume.fx + 0
        @enemy.volume      = game.volume.fx - 0.5
        @death.volume      = game.volume.fx - 0.5