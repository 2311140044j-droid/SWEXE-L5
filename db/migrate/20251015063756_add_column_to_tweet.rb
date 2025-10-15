class AddColumnToTweet < ActiveRecord::Migration[8.0]
  def change
    add_column :tweets, :age, :integer
  end
end
