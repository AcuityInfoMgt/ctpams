json.array!(@clearances) do |clearance|
  json.extract! clearance, :id
  json.url clearance_url(clearance, format: :json)
end
