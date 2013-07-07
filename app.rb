require 'rubygems'
require 'sinatra'
require 'haml'
require './lib/scrabble'
require 'json'
# Helpers
require './lib/render_partial'

# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :public_folder, 'public'
set :haml, {:format => :html5} # default Haml format is :xhtml

# Application routes
get '/' do
  @game = Scrabble.new
  @game.rack= ["c", ' ', 'b', 'b', ' ', 'g', 'e']
  haml :index, :layout => :'layouts/application'
end

get '/about' do
  haml :about, :layout => :'layouts/page'
end
post '/score' do
  puts "params"
  p params
  @game = Scrabble.new
  scrabble_params = params["scrabble"]
  play_word = scrabble_params.delete "play_word"
  score_total = scrabble_params.delete "score_total"
  replace = scrabble_params.delete "replace"
  scrabble_params.each do |method, value|
    p method
    p value
    @game.send("#{method}=", JSON.parse(value))
  end
  unless replace.nil?
    @game.replace(replace)
  end

  p @game.score_total = score_total
  p @game.letters_bag
  @score = @game.play_word play_word unless play_word["word"] == ''
  @word = play_word["word"]

  # rack = JSON.parse(params[:rack])
  # bag = JSON.parse(params[:bag])
  # unless params[:played_words].nil?
  #   played_words = JSON.parse(params[:played_words])
  # else
  #   played_words = []
  # end
  # puts "!!!: #{params[:play_words]}"

  # @game = Scrabble.new(rack, bag, params[:score_total],played_words)

  # bonus = params[:bonus]
  # @word = params[:word]
  # @score = @game.play_word(params[:word],bonus)
  # p @game.played_words
  haml :score, :layout => :'layouts/application'
end

get '/score/' do
  haml :score, :layout => :'layouts/application'
end

