json.array!(@quizzes) do |quiz|
  json.extract! quiz, :id, :difficulty
  json.animal quiz.animal, :id, :name, :sound, :avatar
  json.alternative quiz.alternative, :id, :name, :sound, :avatar
end
