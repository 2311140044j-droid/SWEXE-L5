class RenameMessageToContentInTweets < ActiveRecord::Migration[8.0]
  def change
    rename_column :tweets, :message, :content
  end
end
