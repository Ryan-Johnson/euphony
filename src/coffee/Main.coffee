$(document).ready ->

  # global loader to show progress
  window.loader = new LoaderWidget()

  #start app
  window.app = new Euphony()
  app.initScene()
  app.initMidi ->
    app.getBuiltinMidiIndex (index) ->

      app.setBuiltinMidi index[13], ->
        window.player = new PlayerWidget()
        player.init()
        player.bind('play', app.play)
        player.bind('pause', app.pause)
        player.bind('resume', app.resume)
        player.bind('stop', app.stop)

      $playlist = $('#playlist')
      for filename in index
        $playlist.append($('<li>').text(filename))
      $playlist.on 'click', (event) ->
        player.stop()
        app.setBuiltinMidi $(event.target).text(), ->
          player.play()