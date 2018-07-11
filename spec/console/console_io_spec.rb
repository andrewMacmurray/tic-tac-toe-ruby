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
    output = StringIO.new
    console_io = ConsoleIO.new(input: input, output: output)

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
end
