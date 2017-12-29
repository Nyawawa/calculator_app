class CalculatorController < ApplicationController
  def calculate
    @calculator = Calculator.new(:expression => params[:expression])
    if @calculator.save
      puts "########## calling evaluateExpression ..."
      @calculator.evaluate_expression
      puts "########## evaluateExpression done!"
      render :json => @calculator, :only => [:expression, :result]
    else
      render :json => {expression: params[:expression], result: "Blank Expression"}
    end
  end
end
