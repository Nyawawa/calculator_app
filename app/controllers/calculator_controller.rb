class CalculatorController < ApplicationController
  def calculate
    puts "########## received expression: " + params[:expression]
    puts "########## start http header"
    puts request.original_url
    queryString    = URI.parse(request.original_url).query
    pp queryString
    expressionString = queryString.split("=")[1] # the service only exprects one argument set, so the second part of the string should be the expression 
    puts "########## expression " + expressionString
    puts "########## end http header"
    @calculator = Calculator.new(:expression => expressionString)
    if @calculator.save
      puts "########## calling evaluateExpression ..."
      @calculator.evaluate_expression
      puts "########## evaluateExpression done!"
      render :json => @calculator, :only => [:expression, :result]
    else
      render :json => {expression: expressionString, result: "Blank Expression"}
    end
  end
end
