window.onerror = (message, url, lineNumber) ->
    console.log 'Error: ' + message + ' in ' + url + ' at line ' + lineNumber

scaleManager = new ScaleManager

game = new (Phaser.Game)(scaleManager.gameWidth, scaleManager.gameHeight, Phaser.CANVAS, 'crucialPain', {}, false, false)
# add game states
game.state.add 'Boot', CrucialPain.Boot
game.state.add 'Default', CrucialPain.Default
game.state.add 'Preloader', CrucialPain.Preloader
game.state.add 'MainMenu', CrucialPain.MainMenu
game.state.add 'LevelSelect', CrucialPain.LevelSelect
game.state.add 'Level', CrucialPain.Level
# start the Boot state
game.state.start 'Boot'
