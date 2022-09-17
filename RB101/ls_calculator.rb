require 'yaml'
MESSAGES = YAML.load_file('ls_calculator_messages.yml')


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
  integer?(num) || float?(num)
end

def use_float(num)
  if integer?(num)
    num.to_i
  else
    num.to_f
  end
end

def operation_to_message(oper)
  operator = case oper
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multipling'
  when '4'
    'Dividing'
  end
  operator
end

prompt(MESSAGES['welcome'])
name = ''
loop do
  name = gets.chomp
  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

loop do
  number1 = ''
  loop do
    prompt(MESSAGES['first_num'])
    number1 = gets.chomp
    if valid_number?(number1)
      break
    else
      prompt(MESSAGES['valid_num'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['second_num'])
    number2 = gets.chomp
    if valid_number?(number2)
      break
    else
      prompt(MESSAGES['valid_num'])
    end
  end

  number1 = use_float(number1)
  number2 = use_float(number2)
  
  operator_prompt = <<-MSG
  What operation would you like to perform
      1). Add
      2). Subtract
      3). multiply
      4). divide
  MSG
  prompt(operator_prompt)
  operator = ''
  loop do
    operator = gets.chomp
    if %w[1 2 3 4].include?(operator)
      break
    else
      prompt(MESSAGES['must_choose'])
    end
  end

  result = case operator
          when '1'
            number1 + number2
          when '2'
            number1 - number2
          when '3'
            number1 * number2
          when '4'
            while number2 == 0 || number2 == 0.0
               prompt(MESSAGES['zero_error'])
               number2 = gets.chomp
               number2 = use_float(number2)
            end
            number1.to_f / number2
          end

  prompt("#{operation_to_message(operator)} the two numbers...")
  prompt("The result is #{result}")
  prompt("Do you want to perform another calculation #{name}? (Y to calculate again)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end