require "console/messages"

class ConsoleIO
  def initialize(options = {})
    @input = options[:input] || $stdin
    @output = options[:output] || $stdout
    @messages = options[:messages] || Messages.new
  end

  def clear
    output.print(`clear`)
  end

  def puts(message)
    output.puts(message)
  end

  def print(message)
    output.print(message)
  end

  def read_int_in_range(from, to)
    string_value = get_next
    if valid_digit?(string_value) && in_range?(string_value, from, to)
      string_value.to_i
    else
      print_retry
      read_int_in_range(from, to)
    end
  end

  def read_yes_no
    string_value = get_next
    return true  if yes?(string_value) 
    return false if no?(string_value) 
    print_retry
    read_yes_no
  end

  private
  attr_reader :input, :output, :messages

  def print_retry
    print(messages.unrecognised)
    print(messages.prompt)
  end

  def yes?(value)
    starts_with?("Y", value)
  end

  def no?(value)
    starts_with?("N", value)
  end

  def starts_with?(letter, value)
    value.upcase.start_with?(letter)
  end

  def get_next
    input.gets
  end

  def in_range?(input, from, to)
    input.to_i >= from && input.to_i <= to
  end

  def valid_digit?(input)
    input.match(/^\d$/)
  end
end
