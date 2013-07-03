require_relative 'word_list.rb'
require_relative 'letter_distributions.rb'
require_relative 'rules_list.rb'


class Scrabble
  attr_accessor :rules, :letters_bag, :rack

  def initialize(new_rules=nil)
    reset_bag
    if rules.nil?
      @rules = rules_list
    else
      @rules = new_rules
    end
  end

  def play_word(word, bonus="single")
    word.downcase!
    if @rack.nil?
      fill_rack
    end
    if word_list(word) && in_rack(word)
      sum = score_by_rules(word)
      sum *= bonus_check bonus
      subtract_from_rack(word)
      fill_rack
      return sum
    else
      return false
    end
  end

  def play_words(words)
    sum = 0
    words.split(' ').each do |word|
      sum += play_word(word)
    end
  end

  def bonus_check(bonus)
    return 1 if bonus == "single"
    return 2 if bonus == "double"
    return 3 if bonus == "triple"
  end

  def score_by_rules(word)
    @rules.reduce(0) do |sum, (rule, score)|
      sum += (score * word.scan(rule).length)
    end
  end

  def reset_bag
    @letters_bag = []
    letter_distributions.each do |letter, value|
      value.times{ @letters_bag << letter}
    end
  end

  def subtract_from_rack(word)
    word.each_char do |word_letter|
      index = @rack.index(word_letter)
      @rack.delete_at(index)
    end
  end

  def fill_rack
    @rack ||= []
    tiles_to_get = [7, (7-@rack.length)].min
    tiles_to_get.times do
      index = rand(@letters_bag.length-1)
      @rack << @letters_bag.delete_at(index)
    end
    return @rack
  end

  def in_rack(word)
    word.each_char do |letter|
      return false if @rack.index(letter).nil?
    end
  end

  private
    include WordList
    include LetterDistributions
    include RulesList
end
