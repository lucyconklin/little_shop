class Cart
  attr_accessor :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new
  end

  def number_of_items
    contents.values.sum
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end
end
