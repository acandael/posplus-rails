# root crumb

crumb :front_publications do
  link "Publications", publications_path
end

crumb :publication_series do
  link "POS+ Publication Series", series_path
  parent :front_publications
end

crumb :front_publication do |publication|
  if publication
    link "Publication", publication_path(publication)
  else
    link "Pos+ Publication Series", series_path 
  end
  parent :publication_series
end

crumb :dashboard do
  link "Dashboard", admin_path
  
end


crumb :dashboard_item do |dashboard_item|
  if dashboard_item
    link dashboard_item, admin_path
  else
    link "Dashboard", admin_path
  end
end

crumb :research_themes do
  link "Research Themes", admin_research_themes_path
  parent :dashboard
end

crumb :research_theme do |research_theme| 
  if research_theme
    link research_theme.title, admin_research_theme_path(research_theme)
  else
    link "New Research Theme", admin_research_themes_path
  end
  parent :research_themes
end

crumb :research_projects do
  link "Research Projects", admin_research_projects_path
  parent :dashboard
end

crumb :research_project do |research_project|
  if research_project
    link research_project.title, admin_research_project_path(research_project)
  else
    link "New Research Project", admin_research_projects_path
  end
  parent :research_projects
end

crumb :research_groups do
  link "Affiliated Research Groups", admin_research_groups_path
  parent :dashboard
end

crumb :research_group do |research_group|
  if research_group
    link research_group.name, admin_research_group_path(research_group)
  else
    link "New Affiliated Research Group", admin_research_groups_path
  end
  parent :research_groups
end

crumb :researchers do
  link "Researchers", admin_researchers_path
  parent :dashboard
end

crumb :researcher do |researcher|
  if researcher
    link researcher.fullname, admin_researcher_path(researcher)
  else
    link "New Researcher", admin_researchers_path
  end
  parent :researchers
end

crumb :courses do
  link "Courses", admin_courses_path
  parent :dashboard
end

crumb :course do |course|
  if course
    link course.title, admin_course_path(course)
  else
    link "New Course", admin_courses_path
  end
  parent :courses
end


crumb :news_items do
  link "News Items", admin_news_items_path
  parent :dashboard
end

crumb :news_item do |news_item|
  if news_item
  link news_item.title, admin_news_item_path(news_item)
  else
  link "News Items", admin_news_items_path
  end
  parent :news_items
end

crumb :publications do
  link "Publications", admin_publications_path
  parent :dashboard
end

crumb :publication do |publication|
  if publication
    link publication.title, admin_publication_path(publication)
  else
    link "Publications", admin_publications_path
  end
  parent :publications
end

crumb :data do |publication|
  link "Data", admin_publication_documents_path(publication)
  parent :publication, publication
end

crumb :document do |publication|
  link "Document"
  parent :data, publication
end

crumb :features do
  link "In the picture", admin_features_path
  parent :dashboard
end

crumb :feature do |feature|
  if feature
    link feature.title, admin_feature_path(feature)
  else
    link "In the picture", admin_features_path
  end
  parent :features
end



# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
