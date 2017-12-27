class CalculatorController < ApplicationController
  def calculate
    @calculator = Calculator.new(:expression => params[:expression])
    if @calculator.save
      render :json => @calculator, :only => [:expression, :result]
    else
      render :json => {expression: params[:expression], result: "ERROR"}
    end
  end
end
