def prompt(message)
  puts "=> #{message}"
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def valid_number?(num)
  (integer?(num) || float?(num))
end

def not_zero(num)
  num.to_f.positive?
end

def input_valid?(input)
  loop do
    input = gets.chomp
    break if valid_number?(input) && not_zero(input)

    prompt('Please enter a valid number')
  end
  input.to_f
end

prompt('Welcome to the interest calculator')
prompt('Please enter a user name')
name = ' '
loop do
  name = gets.chomp
  break if name != ''

  prompt('Please enter a valid user name')
end
# input for loan amount
loop do
  # input for loan amount
  prompt('Enter the amount of the loan')
  loan_amount = input_valid?(loan_amount)
  # input for APR
  prompt('Enter the APR of the loan')
  annual_percentage_rate = input_valid?(annual_percentage_rate)
  annual_percentage_rate = annual_percentage_rate.to_f / 100
  # input for loan length
  prompt('Enter the number of months the loan will be payed in')
  months = input_valid?(months)
  # calculate
  monthly_interest_rate = annual_percentage_rate / 12
  monthly_payment = loan_amount * (monthly_interest_rate / (1 - (1 + monthly_interest_rate)**-months))

  total_interest = (monthly_payment * months) - loan_amount

  # output
  prompt("#{name}, your monthly payments for your loan of $#{format('%.2f', loan_amount)} " \
  "will be $#{format('%.2f', monthly_payment)} for #{months.to_i} months")
  prompt("The total interest you will pay is $#{format('%.2f', total_interest)}")
  # calculate again?
  prompt "Would You like to calculate another loan #{name}?  Enter Y to continue"
  continue = gets.chomp
  break if continue.downcase != 'y'
end