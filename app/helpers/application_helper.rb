module ApplicationHelper
  def categories
    Category.all.sort_by_name
  end

  def item(id=params[:item_id])
    Item.find(id)
  end

  def order(id=params[:order_id])
    Order.find(id)
  end

  def status(name=params["status"])
    Status.find_by(name: name)
  end

  def admin(id=params[:id])
    Admin.find(id)
  end

end
