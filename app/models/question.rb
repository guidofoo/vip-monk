class Question < Ohm::Model
  attribute :question
  attribute :question_dt
  attribute :answer
  attribute :answer_dt
  reference :item, Item
end
