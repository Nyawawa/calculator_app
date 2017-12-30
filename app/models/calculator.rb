class Calculator < ApplicationRecord
  require 'parser'
  
  attr_accessor :result

  def evaluate_expression
    parser = Parser.new
    begin
      result = parser.parse(self.expression)
      raise 'Infinity' if result.infinite?
      self.result = result
    rescue => e
      self.result = "Error: " + e.message
    end
  end
  
  def as_json options={}
    {
      expression: self.expression,
      result: self.result
    }
  end
  
end
