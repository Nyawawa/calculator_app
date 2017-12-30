class CalculatorController < ApplicationController
  def calculate
    # using params[] "+" is replaced by " " so the original URL must be retrieved and parsed different
    queryString = URI.parse(request.original_url).query
    if !queryString.blank?
      expressionString = queryString.split("=")[1] # the service only exprects one argument, so the second part of the string should be the expression 
      if !expressionString.blank?
        @calculator = Calculator.new(:expression => expressionString)
        @calculator.evaluate_expression
        render :json => @calculator
      else
        render :json => {expression: expressionString, result: "Error: Blank Expression"}
      end
    else
      render :json => {expression: "No Argument", result: "No Argument"}
    end
    
  end
end
