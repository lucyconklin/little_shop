module ApplicationHelper
  def categories
    Category.all.sort_by_name
  end
end
