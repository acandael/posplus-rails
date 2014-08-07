class Category < ActiveRecord::Base
  has_many :publications
end
