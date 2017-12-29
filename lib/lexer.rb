require 'token'

class Lexer
  def initialize(input)
    @input = input
    @return_previous_token = false
  end

  def get_next_token
    if @return_previous_token
      @return_previous_token = false
      return @previous_token
    end

    token = Token.new

    @input.lstrip! # remove leading whitespace

    case @input
      when /\A\+/ then # string "+"
        token.set_kind_name Token::Plus
      when /\A-/ then # string "-"
        token.set_kind_name Token::Minus
      when /\A\*/ then # string "*"
        token.set_kind_name Token::Multiply
      when /\A\// then # string "/"
        token.set_kind_name Token::Divide
      when /\A\d+(\.\d+)?/ # string "1.2" (d.d)
        token.set_kind_name Token::Number
        token.set_value $&.to_f # store the number (the last successful pattern match) as float 
      when /\A\(/ # string "("
        token.set_kind_name Token::LBracket
      when /\A\)/ # string ")"
        token.set_kind_name Token::RBracket
      when '' # empty string
        token.set_kind_name Token::End
    end

    raise 'Unknown token' if token.unknown?
    @input = $' #keep only the part of the expression after the actual string of the previous successful pattern match 

    @previous_token = token
    token
  end

  def revert
    @return_previous_token = true
  end
end