VALID_CHOICES = %w[rock paper scissors].freeze

def prompt(message)
  puts "=> #{message}"
end

def win?(player1, player2)
  (player1 == 'rock' && player2 == 'scissors') ||
    (player1 == 'paper' && player2 == 'rock') ||
    (player1 == 'scissor' && player2 == 'paper')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt('You won!')
  elsif win?(computer, player)
    prompt('You lost!')
  else
    prompt('You tied')
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose either #{VALID_CHOICES.join(', ')}")
    choice = gets.downcase.chomp
    break if VALID_CHOICES.include?(choice)

    prompt('That was not a valid choice')
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose #{choice} the computer chose #{computer_choice}")
  display_results(choice, computer_choice)
  prompt('Would you like to play again? (Y or N)')
  answer = gets.chomp.downcase
  break if answer != 'y'
end
prompt('Thanks for playing.  Goodbye!')