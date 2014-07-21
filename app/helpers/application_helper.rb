module ApplicationHelper
  def toggle_visibility(object) 
    if object.visible?
      "Hide"
    else
      "Show"
    end
  end
end
