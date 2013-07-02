require 'rubygems'
require 'sinatra'
require 'haml'
require './lib/scrabble'
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
  haml :index, :layout => :'layouts/application'
end

get '/about' do
  haml :about, :layout => :'layouts/page'
end
post '/score/' do
  game = Scrabble.new
  if params[:bonus].nil?
      bonus = "single"
  else
    bonus = params[:bonus]
  end
puts params[:bonus]
  @word = params[:word]
  @score = Scrabble.new.play_word(params[:word],bonus)
  puts @score
  if @score == false
    @score = "Word not found"
  end
  haml :score, :layout => :'layouts/application'
end

get '/score/' do
  haml :score, :layout => :'layouts/application'
end

