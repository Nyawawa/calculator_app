require 'token'

class Lexer
  def initialize(input)
    @input = input
    @return_previous_token = false
  end

  def get_next_token awaitingNumber
    if @return_previous_token
      @return_previous_token = false
      return @previous_token
    end

    token = Token.new

    @input.lstrip! # remove leading whitespace

    if awaitingNumber # because negative numbers are allowed the check for numbers must be seperated from the minus operator
      case @input
        when /\A(-)?\d+(\.\d+)?/ # string "1.2" (d.d)
          token.set_kind Token::Number
          token.set_value $&.to_f # store the number (the last successful pattern match) as float
        when /\A\(/ # string "("
          token.set_kind Token::LBracket
        when /\Asqrt/ # string "sqrt"
          token.set_kind Token::SquRoot
      end
    else    
      case @input
        when /\A\+/ then # string "+"
          token.set_kind Token::Plus
        when /\A-/ then # string "-"
          token.set_kind Token::Minus
        when /\A\*/ then # string "*"
          token.set_kind Token::Multiply
        when /\A\// then # string "/"
          token.set_kind Token::Divide
        when /\A\)/ # string ")"
          token.set_kind Token::RBracket
        when '' # empty string
          token.set_kind Token::End
        when /\A\^/ # string "^" 
          token.set_kind Token::Exponent
        when /\Amod/ # string "mod"
          token.set_kind Token::Modulo
      end
    end

    raise 'Unknown Token' if token.unknown?
    @input = $' #keep only the part of the expression after the actual string of the previous successful pattern match 

    @previous_token = token
    token
  end

  def revert
    @return_previous_token = true
  end
end