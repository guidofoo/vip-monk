class CreateQuestions < Sequel::Migration

  def up
    create_table :questions do
      primary_key :id
      foreign_key :item_id, :items
      String :question, :text=>true
      Date :question_dt
      String :answer, :text=>true
      Date :answer_dt
    end
  end

  def down
    drop_table :questions
  end
end
