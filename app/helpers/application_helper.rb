module ApplicationHelper
  PAGE_SIZE = 10

  def format_to_only_date datetime
    datetime.strftime("%d %b %Y") if datetime
  end
end
