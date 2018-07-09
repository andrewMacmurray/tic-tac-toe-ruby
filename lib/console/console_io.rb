class ConsoleIO
  def initialize(options)
    @input = options[:input]
    @output = options[:output]
    @error_message = "Sorry I didn't recognise that"
  end

  def puts(message)
    output.puts(message)
  end

  def read_int_in_range(from, to)
    val = get_next
    if valid_digit?(val) && in_range?(val, from, to)
      val.to_i
    else
      self.puts(error_message)
      read_int_in_range(from, to)
    end
  end

  private
  attr_reader :input
  attr_reader :output
  attr_reader :error_message

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
