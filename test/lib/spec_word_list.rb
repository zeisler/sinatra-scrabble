require_relative '../../lib/word_list.rb'
require 'minitest/autorun'
require 'minitest/spec'


describe "word_list" do
  it "must find the word cabbage and return true" do
    word_list('cabbage').must_equal true
  end
  it "must not find a miss-spelled or not a true word" do
    word_list('cabage').must_equal false
  end
  it "fails with more than one word" do
    word_list('cabagge apple').must_equal false
  end
end
