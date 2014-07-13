# root crumb
crumb :root do
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
end

crumb :research_project do |research_project|
  if research_project
    link research_project.title, admin_research_project_path(research_project)
  else
    link "New Research Project", admin_research_projects_path
  end
  parent :research_projects
end

crumb :researchers do
  link "Researchers", admin_researchers_path
end

crumb :researcher do |researcher|
  if researcher
    link researcher.name, admin_researcher_path(researcher)
  else
    link "New Researcher", admin_researchers_path
  end
  parent :researchers
end

crumb :courses do
  link "Courses", admin_courses_path
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
end

crumb :publication do |publication|
  if publication
    link publication.title, admin_publication_path(publication)
  else
    link "Publications", admin_publications_path
  end
  parent :publications
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
