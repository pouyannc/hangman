game_words = File.read('google-10000-words.txt').split.select {|word| word.length.between?(5,12) }


