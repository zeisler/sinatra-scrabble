require 'rubygems'
require 'sinatra'
require 'haml'

require './lib/scrabble'
require './lib/scrabble_reinit'
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
  haml :index, :layout => :'layouts/application'
end
get '/test' do
  @game = Scrabble.new
  @game.rack= ["r", ' ', 'n', 'n', 'i', 'n', 'g']
  haml :index, :layout => :'layouts/application'
end

post '/score' do
  puts "params"
  p params
  @game, @word, @score = scrabble_reinit(params)
  haml :score, :layout => :'layouts/application'
end


