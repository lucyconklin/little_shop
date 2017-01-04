require 'rails_helper'

describe Cart do
  it 'the cart be able to contain items' do
    cart = Cart.new
    cart.contents =  create_list(:item, 5)

    expect(cart.contents.count).to eq(5)
  end
end
