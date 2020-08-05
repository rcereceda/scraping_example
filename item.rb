class Item
  class << self; attr_accessor :all end
  attr_accessor :name

  @all = []

  def initialize(name, amount)
    @name = name
    @amount = amount
    self.class.all << self
  end
end
