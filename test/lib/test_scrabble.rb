require_relative '../../lib/scrabble.rb'

require 'minitest/autorun'

class Scrable < MiniTest::Unit::TestCase

  def setup
    @scrabble = Scrabble.new
  end
  def Scrabble_cabbage_equals_14
    assert_equal 14, @scrabble.play_word("cabbage")
  end
  def Scrabble_Cabbage_equals_14
    assert_equal 14, @scrabble.play_word("Cabbage")
  end
  def Scrabble_single_word_equals_14
    assert_equal 14, @scrabble.play_word("cabbage", "single")
  end
  def Scrabble_double_word_equals_28
    assert_equal 28, @scrabble.play_word("cabbage", "double")
  end
  def Scrabble_triple_word_equals_42
    assert_equal 42, @scrabble.play_word("cabbage", "triple")
  end
  def Scrabble_not_word_returns_false
    assert_equal false, @scrabble.play_word("cabage")
  end
end
