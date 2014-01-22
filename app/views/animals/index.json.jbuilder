json.array!(@animals) do |animal|
  json.extract! animal, :id, :name, :image, :sound
  json.url animal_url(animal, format: :json)
end
