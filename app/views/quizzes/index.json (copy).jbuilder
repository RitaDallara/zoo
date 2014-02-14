json.array!(@quizzes) do |quiz|
  json.extract! quiz, :id, :animal_id, :alternative_id, :difficulty
  json.url quiz_url(quiz, format: :json)
end
