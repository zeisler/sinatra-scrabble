require "Shellwords"
module WordList
  def word_list(word)
    if File.exists?('word_list.txt')
        file = "word_list.txt"
    else
      file = File.dirname(__FILE__)+"/word_list.txt"
    end
    system("cat #{file} | ack '^#{Shellwords.escape(word)}\\b'")
  end
end

