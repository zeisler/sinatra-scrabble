require_relative 'word_list.rb'
require_relative 'letter_distributions.rb'
require_relative 'rules_list.rb'


class Scrabble
  attr_accessor :rules, :played_words
  attr_reader :score_total
  def initialize()
    @rules = rules_list
    @score_total = 0
    @played_words = []
    letters_bag
    rack
  end
  def score_total=(total)
    total = total.to_i if total.class == String
    @score_total = total
  end
  def letters_bag
     reset_bag if @letters_bag.nil?
     return @letters_bag
  end
  def letters_bag=(new_bag)
     @letters_bag = new_bag
  end
  def rack
   fill_rack if @rack.nil?
   return @rack
  end
  def rack=(new_rack)
    @rack = new_rack
  end
  def fill_rack
    rack_size = 7
    @rack ||= []
    tiles_to_get = [@letters_bag.length, (rack_size-@rack.length)].min
    @rack += @letters_bag.shuffle.take(tiles_to_get)
    return @rack
  end

  def delete_from_letters_bag(word)
    word.each_char do |letter|
      @letters_bag.delete_at @letters_bag.index(letter)
    end
  end
  def add_to_letters_bag(word)
    word.each_char do |letter|
      @letters_bag << letter
    end
  end

  def play_word(hash)
    word = hash['word']
    blanks = hash['blanks']
    if hash["bonus"].nil?
      bonus = "single"
    else
      bonus = hash["bonus"]
    end
    word.downcase!
    if in_list?(word)
      in_rack?(word)
      subtract_from_rack(word)
      sum = score_by_rules(@word_with_blanks)
      sum *= bonus_check bonus
      @score_total += sum
      @played_words << word
      fill_rack
      return sum
    else
      return "Not a word valid!"
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
  def replace(word)
    subtract_from_rack(word)
    fill_rack
    add_to_letters_bag(word)
  end
  def subtract_from_rack(word)
    blanks = blanks_in_rack
    word.each_char do |letter|
      index = @rack.index(letter)
      if index.nil? && blanks > 0
        blanks -= 1
        @rack.delete_at @rack.index(' ')
      else
        @rack.delete_at(index)
      end
    end
  end

  def blanks_in_rack
    @rack.reduce(0) do |sum, letter|
      sum += letter.scan(/\s/).length
    end
  end

  def find_blank
    @rack.each_with_index do |letter, index|
      if letter =~ /\s/
        return index
      end
    end
  end

  def in_rack?(word)
    blanks = blanks_in_rack
    @word_with_blanks = word
    word.each_char do |letter|
      if @rack.index(letter).nil?
        if blanks >= 0
          blanks -= 1
          @word_with_blanks = @word_with_blanks.sub(letter, ' ')
        else
          return false
        end
      end
    end
    return true
  end

  private
    include WordList
    include LetterDistributions
    include RulesList
end
