json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :start_date, :end_date, :budget_requested, :fiscal_year, :objective, :interest, :law_enforcement, :coordination, :lessons_learned, :sustainability, :city_province, :program_audience, :reprogram, :reprogram_comments, :implementation_status, :program_id, :user_id, :is_archived, :is_denied, :is_active
  json.url project_url(project, format: :json)
end
