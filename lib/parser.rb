require 'lexer'
require 'token'

class Parser

  def parse(input)
    puts "########## start parse"
    @lexer = Lexer.new(input)

    result = expression()

    token = @lexer.get_next_token
    if token.get_kind_name == Token::End
      return result
    else
      raise 'End Expected'
    end
  end

  protected
  AdditiveOperators = [Token::Plus, Token::Minus]
  MultiplicativeOperators = [Token::Multiply, Token::Divide]
  
  # this method evaluates 'factor [{("+" | "-") factor}]'
  def expression
    component1 = factor()

    token = @lexer.get_next_token
    while AdditiveOperators.include?(token.get_kind_name) # stay in the loop as long as there is another combination of '("+" | "-") factor'
      component2 = factor()

      if token.get_kind_name == Token::Plus
        component1 += component2
      else
        component1 -= component2
      end

      token = @lexer.get_next_token
    end
    @lexer.revert # if last token received through get_next_token wasn't a MultiplicativeOperator it must be made available again

    component1
  end

  # this method evaluates 'number [{("*" | "/") number}]'
  def factor
    factor1 = number()

    token = @lexer.get_next_token
    while MultiplicativeOperators.include?(token.get_kind_name) # stay in the loop as long as there is another combination of '("*" | "/") number'
      factor2 = number()

      if token.get_kind_name == Token::Multiply
        factor1 *= factor2
      else
        factor1 /= factor2
      end

      token = @lexer.get_next_token
    end
    @lexer.revert # if last token received through get_next_token wasn't a MultiplicativeOperator it must be made available again

    factor1
  end
  
  # this method evaluates 'Tocken::Number | "(" expression ")"'
  def number
    token = @lexer.get_next_token

    if token.get_kind_name == Token::LBracket # new sub-expression
      value = expression()
      expected_rbracket = @lexer.get_next_token
      raise 'Unbalanced Bracket' unless expected_rbracket.kind_name == Token::RBracket
    elsif token.get_kind_name == Token::Number
      value = token.get_value
    else
      raise 'Not a Number'
    end

    value
  end
end