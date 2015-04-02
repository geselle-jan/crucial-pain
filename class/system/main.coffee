game = new (Phaser.Game)(1024, 768, Phaser.CANVAS, 'crucialPain', {}, false, false)
# add game states
game.state.add 'Boot', CrucialPain.Boot
game.state.add 'Default', CrucialPain.Default
game.state.add 'Preloader', CrucialPain.Preloader
game.state.add 'MainMenu', CrucialPain.MainMenu
game.state.add 'Level', CrucialPain.Level
# start the Boot state
game.state.start 'Boot'
