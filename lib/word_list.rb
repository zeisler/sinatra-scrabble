module WordList
  def in_list?(word)
    if File.exists?('dictionary.txt')
        file = "dictionary.txt"
    else
      file = File.dirname(__FILE__)+"/dictionary.txt"
    end
    if word =~ /[a-z]+/
      system("cat #{file} | grep '^#{word}\\b'")
    else
      return false
    end
  end
end

