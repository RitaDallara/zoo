json.extract! @quiz, :id, :animal_id, :alternative_id, :difficulty, :created_at, :updated_at
json.animal @quiz.animal, :id, :name, :sound, :avatar
json.alternative @quiz.alternative, :id, :name, :sound, :avatar
