require 'lexer'
require 'token'

class Parser

  def parse(input)
    @lexer = Lexer.new(input)

    result = expression()

    token = @lexer.get_next_token false
    if token.get_kind == Token::End
      return result
    else
      raise 'End Expected'
    end
  end

  protected
  AdditiveOperators = [Token::Plus, Token::Minus]
  MultiplicativeOperators = [Token::Multiply, Token::Divide, Token::Modulo]
  
  # this method evaluates 'factor [{("+" | "-") factor}]'
  def expression
    component1 = factor()

    token = @lexer.get_next_token false
    while AdditiveOperators.include?(token.get_kind) # stay in the loop as long as there is another combination of '("+" | "-") factor'
      component2 = factor()

      if token.get_kind == Token::Plus
        component1 += component2
      else
        component1 -= component2
      end

      token = @lexer.get_next_token false
    end
    @lexer.revert # if last token received through get_next_token wasn't a MultiplicativeOperator it must be made available again

    component1
  end

  # this method evaluates 'number [{("*" | "/") number}]'
  def factor
    factor1 = number()

    token = @lexer.get_next_token false
    while MultiplicativeOperators.include?(token.get_kind) # stay in the loop as long as there is another combination of '("*" | "/") number'
      factor2 = number()

      if token.get_kind == Token::Multiply
        factor1 *= factor2
      elsif token.get_kind == Token::Divide
        factor1 /= factor2
      else
        factor1 %= factor2
      end

      token = @lexer.get_next_token false
    end
    @lexer.revert # if last token received through get_next_token wasn't a MultiplicativeOperator it must be made available again

    factor1
  end
  
  # this method evaluates '(Token::Number | "(" expression ")" | "sqrt" number) [{"^" number}]'
  def number
    token = @lexer.get_next_token true
    if token.get_kind == Token::LBracket # new sub-expression
      value = expression()
      expected_rbracket = @lexer.get_next_token false
      raise 'Unbalanced Bracket' unless expected_rbracket.get_kind == Token::RBracket
    elsif token.get_kind == Token::Number
      value = token.get_value
    elsif token.get_kind == Token::SquRoot
      value = square_root()
    else
      raise 'Not a Number'
    end
    value = exponentiation value
  end
  
  # this method evalualtes 'Token::Number "^" number'
  def exponentiation base
    token = @lexer.get_next_token false
    
    if token.get_kind == Token::Exponent # new sub-expression
      exponent = number()
      value = base**exponent
    else
      value = base
      @lexer.revert
    end
    
    value
  end
  
  # this method calculates the square root of a Number returned by number()
  def square_root
    value = number()
    if value >= 0
      squroot = Math.sqrt(value)
    else
      raise 'Sqrt of Negative Number'
    end
  end
end