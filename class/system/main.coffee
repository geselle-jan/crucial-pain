window.onerror = (message, url, lineNumber) ->
    console.log 'Error: ' + message + ' in ' + url + ' at line ' + lineNumber

scaleManager = {}

game = {}

onDeviceReady = ->
    scaleManager = new ScaleManager

    game = new (Phaser.Game)(scaleManager.gameWidth, scaleManager.gameHeight, Phaser.CANVAS, 'crucialPain', {}, false, false)

    # add game states
    game.state.add 'Boot', CrucialPain.Boot
    game.state.add 'Default', CrucialPain.Default
    game.state.add 'Preloader', CrucialPain.Preloader
    game.state.add 'MainMenu', CrucialPain.MainMenu
    game.state.add 'LevelSelect', CrucialPain.LevelSelect
    game.state.add 'Level', CrucialPain.Level

    window.analytics?.debugMode()
    window.analytics?.startTrackerWithId 'UA-64471226-1'

    # start the Boot state
    game.state.start 'Boot'

waitForAnalytics = () ->
    if window.analytics
        onDeviceReady()
    else
        setTimeout (->
            alert('trying to find analytics');
            waitForAnalytics();
        ), 1000

onBodyLoad = () ->
    window.isphone = false
    if document.URL.indexOf('http://') == -1 and document.URL.indexOf('https://') == -1
        window.isphone = true
    if window.isphone
        #waitForAnalytics()
        document.addEventListener 'deviceready', onDeviceReady, false
    else
        onDeviceReady()