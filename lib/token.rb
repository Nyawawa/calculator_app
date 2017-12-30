class Token
  Plus      = 0
  Minus     = 1
  Multiply  = 2
  Divide    = 3
  Modulo    = 9

  Number    = 4

  LBracket  = 5
  RBracket  = 6
  
  End       = 7

  Exponent  = 8
  
  
  

  attr_accessor :kind_name
  attr_accessor :value #only needed for kind Number, in all other cases :value stays nil as initialized

  def initialize
    @kind_name = nil
    @value = nil
  end

  def unknown?
    @kind_name.nil?
  end
  
  def set_kind_name kind_name
    @kind_name = kind_name
  end
  
  def set_value value
    @value = value
  end
  
  def get_kind_name
    @kind_name
  end
  
  def get_value
    @value
  end
end