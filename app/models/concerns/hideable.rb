module Hideable
  extend ActiveSupport::Concern
  
  def visible?
    visible
  end

  def toggle_visibility!
    if visible?
      update_attribute(:visible, false)
    else
      update_attribute(:visible, true)
    end
  end
end
