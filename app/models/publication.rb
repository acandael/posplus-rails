class Publication < ActiveRecord::Base
  include Hideable

  validates :title, :reference, presence: true

  belongs_to :research_project

end
