module Closeable
  extend ActiveSupport::Concern

  def open?
    active
  end

  def toggle_active!
    if open?
      update_attribute(:active, false)
    else
      update_attribute(:active, true)
    end
  end
end
