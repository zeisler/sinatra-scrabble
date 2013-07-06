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
  @game = Scrabble.new(["c", ' ', 'b', 'b', ' ', 'g', 'e'])
  haml :index, :layout => :'layouts/application'
end

get '/about' do
  haml :about, :layout => :'layouts/page'
end
post '/score/' do
  puts "params"
  p params
  rack = JSON.parse(params[:rack])
  bag = JSON.parse(params[:bag])
  unless params[:played_words].nil?
    played_words = JSON.parse(params[:played_words])
  else
    played_words = []
  end
  puts "!!!: #{params[:play_words]}"

  @game = Scrabble.new(rack, bag, params[:score_total],played_words)

  bonus = params[:bonus]
  @word = params[:word]
  @score = @game.play_word(params[:word],bonus)
  p @game.played_words
  haml :score, :layout => :'layouts/application'
end

get '/score/' do
  haml :score, :layout => :'layouts/application'
end

