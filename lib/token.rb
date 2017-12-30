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
  SquRoot   = 10
  
  attr_accessor :kind
  attr_accessor :value #only needed for kind Number, in all other cases :value stays nil as initialized

  def initialize
    @kind = nil
    @value = nil
  end

  def unknown?
    @kind.nil?
  end
  
  def set_kind kind
    @kind = kind
  end
  
  def set_value value
    @value = value
  end
  
  def get_kind
    @kind
  end
  
  def get_value
    @value
  end
end