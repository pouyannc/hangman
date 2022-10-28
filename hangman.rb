def user_guess(letters_used, secret_word_letters_guessed)
  loop do
    letter = gets.chomp.downcase
    if letters_used.any?(letter) || secret_word_letters_guessed.any?(letter)
      puts 'That letter has been used already. Enter a new letter: '
      next
    end
    return letter if letter.length == 1 && letter =~ /\D/
    puts 'Please enter a single letter.'
  end
end

game_words = File.read('google-10000-words.txt').split.select {|word| word.length.between?(5,12) }

secret_word = game_words.sample
secret_word_length = secret_word.length
secret_word_letters_guessed = Array.new(secret_word_length, '_')
lives = 5
letters_used = []

while lives > 0 do
  puts "\nLives remaining: #{lives}"

  puts secret_word_letters_guessed.join(' ')

  puts "\nEnter letter: "
  letter_guess = user_guess(letters_used, secret_word_letters_guessed)

  if secret_word.split('').any?(letter_guess)
    secret_word.split('').each_with_index {|letter, i| secret_word_letters_guessed[i] = letter if letter_guess == letter }
  else
    letters_used.push(letter_guess)
    lives -= 1
  end
end

p secret_word
