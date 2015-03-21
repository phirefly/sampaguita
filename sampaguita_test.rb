require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

class SampaguitaLexer

  def tokenize code
    tokens = []

    if number = code[/\A([0-9])+/,1]
      tokens << [:NUMBER, number.to_i]
      # todo: increment current location with size of each character being analyzed
    elsif string = code[/\A"([A-Za-z]+)"/,1]
      tokens << [:STRING, string]
    elsif identifier = code[/([A-Za-z]+)/, 1]
      tokens << [:IDENTIFIER, identifier]
    end
  end
end

class TestSampaguitaLexer < Minitest::Test
  describe SampaguitaLexer do
    before do
      @lexer = SampaguitaLexer.new
    end

    it 'tokenizes a number' do
      assert_equal [[:NUMBER, 1]], SampaguitaLexer.new.tokenize("1")
    end

    it 'tokenizes a string' do
      assert_equal [[:STRING, "something"]], SampaguitaLexer.new.tokenize('"something"')
    end

    it 'tokenizes an identifier' do
      assert_equal [[:IDENTIFIER, "name"]], SampaguitaLexer.new.tokenize('name')
    end
  end
end

# def test_number
#   assert_equal [[:NUMBER, 1]], Lexer.new.tokenize("1")
# end

# def test_string
#   assert_equal [[:STRING, "hi"]], Lexer.new.tokenize('"hi"')
# end

# def test_identifier
#   assert_equal [[:IDENTIFIER, "name"]], Lexer.new.tokenize('name')
# end

# def test_constant
#   assert_equal [[:CONSTANT, "Name"]], Lexer.new.tokenize('Name')
# end

# def test_operator
#   assert_equal [["+", "+"]], Lexer.new.tokenize('+')
#   assert_equal [["||", "||"]], Lexer.new.tokenize('||')
# end
