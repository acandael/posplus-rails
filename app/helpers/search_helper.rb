module SearchHelper
  def number_of_results
    @publications.size.to_i + @research_projects.size.to_i
  end
end
