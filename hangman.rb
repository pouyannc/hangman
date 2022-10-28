game_words = File.read('google-10000-words.txt').split.select {|word| word.length.between?(5,12) }

secret_word = game_words.sample
secret_word_length = secret_word.length

lives = 5

while lives > 0 do
  puts 'Enter letter: '
  loop do
    letter_guess = gets.chomp
    break if letter_guess.length == 1 && letter_guess.downcase =~ /\D/
    puts 'Please enter a single letter.'
  end

  lives = 0
end

p secret_word
