def scrabble_reinit(params)
  unless params["scrabble"].nil?
    game = Scrabble.new
    scrabble_params = params["scrabble"]
    play_word = scrabble_params.delete "play_word"
    score_total = scrabble_params.delete "score_total"
    replace = scrabble_params.delete "replace"
    scrabble_params.each do |method, value|
      game.send("#{method}=", JSON.parse(value))
    end
    unless replace.nil?
      game.replace(replace)
    end
    score = game.play_word play_word unless play_word["word"] == ''
    word = play_word["word"]
    return game, word, score
  end
end
