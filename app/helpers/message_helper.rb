module MessageHelper

  def flash_message_remove_from_cart(item)
    message = "Succesfully removed #{view_context.link_to(item.title, item)} from your cart."
    flash[:success] = message
  end

  def flash_message_add_item_to_cart(item)
    message = "You have added 1 #{item.title} to your cart."
    flash[:success] = message
  end

  def flash_message_successful_login
    flash[:success] = 'Successfully logged in!'
  end

  def flash_message_successful_order
    flash[:success] = "Order was successfully placed."
  end
end
