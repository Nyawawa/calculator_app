class Calculator < ApplicationRecord
  require 'parser'
  
  validates :expression, presence: true, allow_blank: false
  
  def evaluate_expression
    puts "########## start evaluateExpression"
    parser = Parser.new
    puts parser.inspect
    begin
      puts "########## call parse"
      result = parser.parse(self.expression)
      puts "########## result = " + result.to_s
      self.result = result
    rescue => e
      puts "########## error: (message) " + e.message + ", (to_s) " + e.to_s
      self.result = "Error: " + e.message
    end
  end
  
end
