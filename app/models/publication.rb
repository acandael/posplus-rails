class Publication < ActiveRecord::Base
  validates :title, :reference, presence: true

  belongs_to :research_project

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
