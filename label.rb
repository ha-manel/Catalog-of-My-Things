class Label
  attr_accessor :items, :name, :id

  def initialize(name, id = nil)
    @id = id || Random.rand(1..1000)
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.label= self
  end
end
