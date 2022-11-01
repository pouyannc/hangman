require 'json'

class HangmanGame

  @@game_words = File.read('google-10000-words.txt').split.select {|word| word.length.between?(5,12) }

  attr_accessor :secret_word, :secret_word_length, :secret_word_letters_guessed, :lives, :letters_used

  def initialize()
    @secret_word = @@game_words.sample
    @secret_word_length = @secret_word.length
    @secret_word_letters_guessed = Array.new(@secret_word_length, '_')
    @lives = 8
    @letters_used = []
  end

  def show_display
    puts "\nLives remaining: #{@lives}\n
          #{@secret_word_letters_guessed.join(' ')}\n
          Letters used: #{@letters_used.join(', ')}"
  end

  def user_guess
    loop do
      letter = gets.chomp.downcase
      if @letters_used.any?(letter) || @secret_word_letters_guessed.any?(letter)
        puts 'That letter has been used already. Enter a new letter: '
        next
      end
      return letter if letter.length == 1 && letter =~ /\D/ || letter == 'save'
      puts 'Please enter a single letter (or "save" to save and quit).'
    end
  end

  def update_display_info(letter_guess)
    if @secret_word.split('').any?(letter_guess)
      @secret_word.split('').each_with_index {|letter, i| @secret_word_letters_guessed[i] = letter if letter_guess == letter }
    else
      @letters_used.push(letter_guess)
      @lives -= 1
    end

    return game_end_check
  end

  def game_end_check
    if @secret_word_letters_guessed.join('') == @secret_word
      sleep 1
      puts "\n#{@secret_word}"
      sleep 1
      puts "You win!"
      return true
    elsif @lives == 0
      sleep 1
      puts "You lose."
      puts "\nThe word was #{@secret_word}"
      return true
    end
  end



end

puts "Hangman!\nType 'save' at any point to save and quit\nPress enter to start"
gets

game = HangmanGame.new
game_end = false

loop do
  game.show_display

  puts "\nEnter letter: "
  letter_guess = game.user_guess

  if letter_guess == 'save'
    puts '...Game saved'
    break
  end
  
  game_end = game.update_display_info(letter_guess)

  break if game_end == true
  
end
