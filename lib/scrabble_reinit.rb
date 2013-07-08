def scrabble_reinit(params)
  unless params["scrabble"].nil?
    game = Scrabble.new
    scrabble_params = params["scrabble"]
    play_word = scrabble_params.delete "play_word"
    rack = scrabble_params.delete("rack")
    rack = JSON.parse rack
    rack_container = []
    rack.each do |item|
      if item["blank"]
        rack_container << ' '
      else
        rack_container << item["letter"]
      end
    end
    rack = rack_container
    score_total = scrabble_params.delete "score_total"
    replace = scrabble_params.delete "replace"
    scrabble_params.each do |method, value|
      game.send("#{method}=", JSON.parse(value))
    end
    game.rack = rack
    unless replace.nil?
      game.replace(replace)
    end
    score = game.play_word play_word unless play_word["word"] == ''
    word = play_word["word"]
    return game, word, score
  end
end
