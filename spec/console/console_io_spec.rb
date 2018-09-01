require "console/console_io"
require "console/messages"

describe ConsoleIO do
  let(:unrecognised) { Messages.new.unrecognised }

  it "prints messages to the screen" do
    output = StringIO.new
    console_io = ConsoleIO.new(output: output)
    console_io.puts("hello")

    expect(output.string).to eq("hello\n")
  end

  it "reads an integer in a given range" do
    input = StringIO.new("3")
    console_io = ConsoleIO.new(input: input)

    result = console_io.read_int_in_range(1, 9)
    expect(result).to eq(3)
  end

  it "prints an error message for non integer input
      retries until a valid input found" do
    input = StringIO.new("hello\n3")
    output = StringIO.new
    console_io = ConsoleIO.new(input: input, output: output)

    result = console_io.read_int_in_range(1, 9)

    expect(output.string).to include(unrecognised)
    expect(result).to eq(3)
  end

  it "prints an error if integer not within range" do
    input = StringIO.new("12\n0\n5")
    output = StringIO.new
    console_io = ConsoleIO.new(input: input, output: output)

    result = console_io.read_int_in_range(1, 9)

    expect(output.string).to include(unrecognised)
    expect(result).to eq(5)
  end

  it "reads a yes input and returns true" do
    input = StringIO.new("yEssS")
    console_io = ConsoleIO.new(input: input)

    result = console_io.read_yes_no

    expect(result).to be(true)
  end

  it "reads a no input and returns false" do
    input = StringIO.new("NO")
    console_io = ConsoleIO.new(input: input)

    result = console_io.read_yes_no

    expect(result).to be(false)
  end

  it "retries until it reaches a yes or no" do
    input = StringIO.new("3\nblah\nyes")
    output = StringIO.new
    console_io = ConsoleIO.new(input: input, output: output)    
    
    result = console_io.read_yes_no

    expect(output.string).to include(unrecognised)
    expect(result).to be(true)
  end
end
