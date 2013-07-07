module WordList
  def in_list?(word)
    if File.exists?('word_list.txt')
        file = "word_list.txt"
    else
      file = File.dirname(__FILE__)+"/word_list.txt"
    end
    if word =~ /[abc]+/
      system("cat #{file} | ack '^#{word}\\b'")
    else
      return false
    end
  end
end

