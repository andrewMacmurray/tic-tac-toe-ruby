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
    val = get_next
    if valid_digit?(val) && in_range?(val, from, to)
      val.to_i
    else
      puts(messages.unrecognised)
      print(messages.prompt)
      read_int_in_range(from, to)
    end
  end

  private
  attr_reader :input
  attr_reader :output
  attr_reader :messages

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
