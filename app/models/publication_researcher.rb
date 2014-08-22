class PublicationResearcher < ActiveRecord::Base
  belongs_to :publication
  belongs_to :researcher
end
