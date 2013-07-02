require_relative 'word_list.rb'

class Scrabble
  attr_reader :rules
  def initialize(rules = nil)
    if rules.nil?
      @rules = {
      /[aeioulnrst]/ => 1,
      /[dg]/ => 2,
      /[bcmp]/ => 3,
      /[fhvwy]/ => 4,
      /[k]/ => 5,
      /[jx]/ => 8,
      /[qz]/ => 10
    }
    else
      @rules = rules
    end
  end

  def play_word(word, bonus="single")
    word.downcase!
    if is_word(word)
      sum = score_by_rules(word)
      sum *= bonus_check bonus
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

  def is_word(word)
    word_list(word)
  end
end

