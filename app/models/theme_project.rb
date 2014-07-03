class ThemeProject < ActiveRecord::Base
  belongs_to :research_theme
  belongs_to :research_project
end
