module ApplicationHelper
  def format_to_only_date datetime
    datetime.strftime("%d %b %Y") if datetime
  end

  def show_errors object, field_name
    unless object.errors.nil?
      if object.errors.any? && !object.errors.messages[field_name].blank?
        object.errors.messages[field_name][0]
      end
    end
  end
end
