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
    # ,letters_bag=nil,played_words=nil,score_total=nil,new_rules=nil)
  #   if played_words.nil?
  #     played_words = []
  #   else
  #     @played_words = played_words
  #   end
  #   if rules.nil?
  #
  #   else
  #     @rules = new_rules
  #   end
  #   if score_total.nil? || score_total.length == 0
  #     @score_total = 0
  #   else
  #     @score_total = score_total.to_i
  #   end
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
    #get the minimum needed to fill the rack or the min in the bag
    tiles_to_get = [@letters_bag.length, (rack_size-@rack.length)].min
    # tiles_to_get.times do
    #   index = rand(@letters_bag.length-1)
    #   @rack << @letters_bag.delete_at(index)
    # end
    @rack += @letters_bag.shuffle.take(tiles_to_get)
    return @rack
  end

  def play_word(hash)
    word = hash['word']
    blanks = hash['blanks']
    if hash["bonus"].nil?
      bonus = "single"
    else
      bonus = hash["bonus"]
    end
    puts word
    word.downcase!
    if in_list?(word)
      in_rack?(word)
      subtract_from_rack(word)
      # word = sub_blanks(word)
      sum = score_by_rules(word)
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
    word.each_char do |letter|
      if @rack.index(letter).nil?
        if blanks >= 0
          blanks -= 1
        else
          return false
        end
      end
    end
    return true
  end

  # def sub_blanks(word)
  #   blanks = blanks_in_rack
  #   index = 0
  #   word.each_char do |letter|
  #     if @rack.index(letter).nil?
  #       if blanks >= 0
  #         blanks -= 1
  #         word[index] = " "
  #         @rack.delete_at(find_blank)
  #       else
  #         return false
  #       end
  #     else
  #       subtract_from_rack(letter)
  #     end
  #     index += 1
  #   end
  #   return word
  # end

  private
    include WordList
    include LetterDistributions
    include RulesList
end
