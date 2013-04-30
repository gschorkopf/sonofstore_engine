class AddLongFormtoQuestionTable < ActiveRecord::Migration
  def change
    add_column :questions, :long_form, :string, :limit => 100
  end
end
