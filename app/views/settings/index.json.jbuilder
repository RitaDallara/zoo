json.array!(@settings) do |setting|
  json.extract! setting, :id, :optone, :opttwo, :optthree
  json.url setting_url(setting, format: :json)
end
