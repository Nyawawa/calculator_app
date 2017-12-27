class CalculatorController < ApplicationController
  def calculate
    expression = params[:expression]
    puts "###########" + expression
  end
end
