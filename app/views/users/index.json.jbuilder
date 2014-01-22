json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :max_easy, :max_medium, :max_hard
  json.url user_url(user, format: :json)
end
