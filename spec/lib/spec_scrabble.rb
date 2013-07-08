require_relative '../../lib/scrabble.rb'
require 'minitest/autorun'
require 'minitest/spec'

describe "Scrabble" do
  describe "play_word method" do
    before do
      @scrabble = Scrabble.new
      @scrabble.rack= %w(c a b b a g e)
    end
    it "take in arguments for letters and bonus" do
      score = @scrabble.play_word({"bonus" => "single", "word" => "cabbage"})
      score.must_equal 14
    end
    it "take in arguments for bonus with double" do
      score = @scrabble.play_word({"bonus" => "double", "word" => "cabbage"})
      score.must_equal 28
    end
    it "take in arguments for bonus with triple" do
      score = @scrabble.play_word({"bonus" => "triple", "word" => "cabbage"})
      score.must_equal 42
    end
    describe "play_word and using blanks" do
      it "can substitute a blank for a letter not in rack and score that letter as a blank" do
        @scrabble = Scrabble.new
        @scrabble.rack= ['r',' ', 'n','n','i','n','g']
        score = @scrabble.play_word({"bonus" => "single", "word" => "running"})
        score.must_equal 7
      end
      it "can substitute a two blanks for a letter not in rack and score those letter as a blank" do
        @scrabble = Scrabble.new
        @scrabble.rack= ['r',' ','n','n',' ','n','g']
        score = @scrabble.play_word({"bonus" => "single", "word" => "running"})
        score.must_equal 6
      end
    end
  end
  describe "replace" do
    it "takes in letters to be exchanged for other letters in the bag" do
      @game = Scrabble.new
      @game.rack = ["r", 'u', 'n', 'n', 'i', 'n', 'g']
      old_rack = @game.rack
      @game.replace "nn"
      @game.rack.wont_equal old_rack
    end
    it "when replacing letters from rack they will be added back to the bag" do
      @game = Scrabble.new
      @game.rack = ["r", 'u', 'a', 'a', 'i', 'n', 'g']
      @game.delete_from_letters_bag @game.rack.join
      class Bag
        include LetterDistributions
      end
      old_bag = Bag.new.letter_distributions
      @game.replace "ng"
      n_s = @game.letters_bag.each_index.select{|i| @game.letters_bag[i] == 'n'}.count
      g_s =  @game.letters_bag.each_index.select{|i| @game.letters_bag[i] == 'g'}.count
      n_s.must_equal (old_bag['n'])
      g_s.must_equal (old_bag['g'])
    end
  end
  describe "score_total" do
    it "will keep track of the total score" do
      @game = Scrabble.new
      @game.rack= %w(c a b b a g e)
      @game.delete_from_letters_bag @game.rack.join
      @game.play_word ({"word" => "cabbage"})
      @game.rack= %w(c a b b a g e)
      @game.play_word ({"word" => "cabbage"})

      @game.score_total.must_equal 28
    end
  end
  describe "played_words" do
    it "remember all played words in a game" do
      @game = Scrabble.new
      @game.rack= %w(c a b b a g e)
      @game.delete_from_letters_bag @game.rack.join
      @game.play_word ({"word" => "cabbage"})
      @game.rack= %w(c a b b a g e)
      @game.play_word ({"word" => "cabbage"})
      @game.played_words.must_equal ["cabbage", "cabbage"]
    end
  end
end
