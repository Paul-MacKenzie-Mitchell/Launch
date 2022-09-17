COUNT_TO_WIN = 3
VALID_CHOICES = { 'rock' => 'r',
                  'paper' => 'p',
                  'scissors' => 's',
                  'spock' => 'sp',
                  'lizard' => 'l' }

WIN_CONDITIONS = {  'rock' => %w[scissors lizard s l],
                    'r' => %w[scissors lizard s l],
                    'paper' => %w[rock spock r sp],
                    'p' => %w[rock spock r sp],
                    'scissors' => %w[paper lizard p l],
                    's' => %w[paper lizard p l],
                    'spock' => %w[rock scissors r s],
                    'sp' => %w[rock scissors r s],
                    'lizard' => %w[spock paper sp p],
                    'l' => %w[spock paper sp p] }

# input methods

def input_user_choice(num, input)
  loop do
    prompt("Round #{num}!")
    prompt("Choose either #{VALID_CHOICES.keys.join(', ')} (#{VALID_CHOICES.values.join(', ')})")

    input = gets.downcase.chomp
    system 'clear'
    return input if VALID_CHOICES.include?(input)
    return input if VALID_CHOICES.value?(input)

    prompt('That was not a valid choice')
  end
end

# conditional methods
def answer_to_yes_or_no
  answer = gets.chomp.downcase
  continue_with_request = %w[y yes]
  continue_with_request.include?(answer)
end

def win?(player1, player2)
  WIN_CONDITIONS[player1.to_s][0] == player2 ||
    WIN_CONDITIONS[player1.to_s][1] == player2 ||
    WIN_CONDITIONS[player1.to_s][2] == player2 ||
    WIN_CONDITIONS[player1.to_s][3] == player2
end

def game_over?(count)
  count['player_win_count'] == 3 ||
    count['computer_win_count'] == 3
end
# display methods

def prompt(message)
  puts "\n => #{message}"
end

def display_unabreviated_input(input)
  if VALID_CHOICES.key?(input)
    input
  else
    VALID_CHOICES.key(input)
  end
end

def display_results(player, computer, round)
  if win?(player, computer)
    prompt("You won round #{round}!")
  elsif win?(computer, player)
    prompt("You lost round #{round}!")
  else
    prompt("You tied round #{round}")
  end
end

def display_round_results(player1, player2, count)
  if win?(player1, player2)
    count['player_win_count'] += 1
  elsif win?(player2, player1)
    count['computer_win_count'] += 1
  else
    count['tie_count'] += 1
  end
  count
end

def display_win_or_wins?(num)
  if num != 1
    'wins'
  else
    'win'
  end
end

def display_loss_or_losses?(num)
  if num != 1
    'losses'
  else
    'loss'
  end
end

def display_tie_or_ties(num)
  if num != 1
    'ties'
  else
    'tie'
  end
end

def display_number_of_wins(wins)
  prompt("Your score is
  #{wins['player_win_count']} #{display_win_or_wins?(wins['player_win_count'])}
  #{wins['computer_win_count']} #{display_loss_or_losses?(wins['computer_win_count'])}")
  puts("  #{wins['tie_count']} #{display_tie_or_ties(wins['tie_count'])}") if wins['tie_count'] != 0
end

def display_winner(wins)
  prompt('You won the match! :)') if wins['player_win_count'] == COUNT_TO_WIN
  prompt('You lost the match... :(') if wins['computer_win_count'] == COUNT_TO_WIN
end

# Formatted messages
rules = <<-MSG
          Scissors cuts paper,#{' '}
          paper covers rock,#{' '}
          rock crushes lizard,#{' '}
          lizard poisons Spock,#{' '}
          Spock smashes scissors,#{' '}
          scissors decapitates lizard,#{' '}
          lizard eats paper,#{' '}
          paper disproves Spock,#{' '}
          Spock vaporizes rock,#{' '}
          and as it always has, rock crushes scissors.
MSG

start_message = <<~MSG
  Welcome to 'Rock, Paper, Scissors, Spock, Lizard
  #{'  '}
  #{'  '}
          First to #{COUNT_TO_WIN} wins!
  #{'  '}
MSG

# begin program

prompt(start_message)
prompt('Would you like to see the rules? (Y or N)')

if answer_to_yes_or_no
  system 'clear'
  print(rules)
  prompt('Hit any key to continue')
  any_key = gets.chomp
  system 'clear' if any_key
end

# loops entire game
loop do
  round = 1
  win_count = { 'player_win_count' => 0,
                'computer_win_count' => 0,
                'tie_count' => 0 }
  # loops round
  loop do
    choice = ''
    choice = input_user_choice(round, choice)
    computer_choice = VALID_CHOICES.keys.sample.to_s
    prompt("You chose #{display_unabreviated_input(choice)}
    the computer chose #{display_unabreviated_input(computer_choice)}")
    display_results(choice, computer_choice, round)
    round += 1
    win_count = display_round_results(choice, computer_choice, win_count)
    display_number_of_wins(win_count)
    display_winner(win_count)
    break if game_over?(win_count)
  end

  prompt('Would you like to play again? (Y or N)')
  break unless answer_to_yes_or_no

  system 'clear'
end
prompt('Thanks for playing.  Goodbye!')