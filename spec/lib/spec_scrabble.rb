require_relative '../../lib/scrabble.rb'
require 'minitest/autorun'
require 'minitest/spec'

describe "Scrabble" do
  before do
    @scrabble = Scrabble.new
    @scrabble.rack= %w(c a b b a g e)
    # params ={"play_word"=>{"bonus"=>"single", "letters"=>["c", "a", "b", "b", "a", "g", "e"]}, "rack"=>"[\"c\",\" \",\"b\",\"b\",\" \",\"g\",\"e\"]", "letters_bag"=>"[\" \",\" \",\"e\",\"e\",\"e\",\"e\",\"e\",\"e\",\"e\",\"e\",\"e\",\"e\",\"e\",\"e\",\"a\",\"a\",\"a\",\"a\",\"a\",\"a\",\"a\",\"a\",\"a\",\"i\",\"i\",\"i\",\"i\",\"i\",\"i\",\"i\",\"i\",\"i\",\"o\",\"o\",\"o\",\"o\",\"o\",\"o\",\"o\",\"o\",\"n\",\"n\",\"n\",\"n\",\"n\",\"n\",\"r\",\"r\",\"r\",\"r\",\"r\",\"r\",\"t\",\"t\",\"t\",\"t\",\"t\",\"t\",\"l\",\"l\",\"l\",\"l\",\"s\",\"s\",\"s\",\"s\",\"u\",\"u\",\"u\",\"u\",\"d\",\"d\",\"d\",\"d\",\"g\",\"g\",\"g\",\"b\",\"b\",\"c\",\"c\",\"m\",\"m\",\"p\",\"p\",\"f\",\"f\",\"h\",\"h\",\"v\",\"v\",\"w\",\"w\",\"y\",\"y\",\"k\",\"j\",\"x\",\"q\",\"z\"]", "score_total"=>"0"}
    # params.each do |method, value|
    #   @scrabble.send("#{method}=", value)
    # end
  end
  describe "play_word method" do
    it "take in arguments for letters and bonus" do
      score =@scrabble.play_word({"bonus" => "single", "letters" => ["c", "a", "b", "b", "a", "g", "e"]})
      score.must_equal 14
    end
  end

  # it "return 14 for word cabbage" do
  #   @scrabble.score_by_rules("cabbage").must_equal 14
  # end
  # it "is case insensitive" do
  #   @scrabble.play_word("CABBAGe").must_equal 14
  # end
  # it "can take bonus arg single" do
  #   @scrabble.play_word("cabbage", "single").must_equal 14
  # end
  # it "can take bonus arg double" do
  #     @scrabble.play_word("cabbage", "double").must_equal 28
  # end
  # it "can take bonus arg triple" do
  #     @scrabble.play_word("cabbage", "triple").must_equal 42
  # end
  #   it "returns false for things that are not words" do
  #     @scrabble.play_word("cabage").must_equal 'Not a valid word!'
  # end
  # it "removes letters from rack when word is played" do
  #   @scrabble.rack = %w(p u a y f r e)
  #   p_index = @scrabble.rack.index('p')
  #   @scrabble.play_word('pay')
  #   new_p_index = @scrabble.rack.index("p")
  #   if @scrabble.rack.index("p")
  #     (p_index.equal?(new_p_index)).must_equal false
  #   else
  #     @scrabble.rack.index("p").must_equal nil
  #   end
  # end
  # it "has filled rack to 7 after played" do
  #   @scrabble.rack = %w(p u a y f r e)
  #   @scrabble.play_word('pay')
  #   @scrabble.rack.length.must_equal 7
  # end
  # it "has removed letters from bag when added to rack" do
  #   #these values not subtracted from bag
  #   @scrabble.rack = %w(p u a y f r e)
  #   @scrabble.play_word('pay')
  #   #when word is played the rack is fill up to 7
  #   #substacting from the bag
  #   @scrabble.letters_bag.length.must_equal (100 - 3)
  # end
  # it "method in_rack can substitute a blank for a letter" do
  #   @sub = Scrabble.new(["c", ' ', 'b', 'b,', 'a', 'g', 'e'])
  #   @sub.in_rack?("cabbage").must_equal true
  # end
  # it "can play a blank for any letter" do
  #   @game = Scrabble.new(["c", ' ', 'b', 'b', 'a', 'g', 'e'])
  #   @game.play_word("cabbage").must_equal 13
  # end
end
