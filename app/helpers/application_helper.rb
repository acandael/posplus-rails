module ApplicationHelper
  def toggle_visibility(object) 
    if object.visible?
      "Hide"
    else
      "Show"
    end
  end

  def toggle_active(object)
    if object.active?
      "Close"
    else
      "Open"
    end
  end
end
