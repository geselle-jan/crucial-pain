params = Phaser.Net::getQueryString()
game = new (Phaser.Game)(1024, 768, Phaser.CANVAS, 'crucialPain', {}, false, false)
# add game states
game.state.add 'Boot', TinyRPG.Boot
game.state.add 'Default', TinyRPG.Default
game.state.add 'Preloader', TinyRPG.Preloader
game.state.add 'MainMenu', TinyRPG.MainMenu
game.state.add 'Town', TinyRPG.Town
# start the Boot state
game.state.start 'Boot'
