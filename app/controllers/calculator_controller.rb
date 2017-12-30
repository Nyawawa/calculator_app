class CalculatorController < ApplicationController
  def calculate
    # using params[] "+" is replaced by " " so the original URL must be retrieved and parsed
    queryString    = URI.parse(request.original_url).query
    expressionString = queryString.split("=")[1] # the service only exprects one argument, so the second part of the string should be the expression 
    @calculator = Calculator.new(:expression => expressionString)
    if @calculator.save
      @calculator.evaluate_expression
      render :json => @calculator
    else
      render :json => {expression: expressionString, result: "Error: Blank Expression"}
    end
  end
end
