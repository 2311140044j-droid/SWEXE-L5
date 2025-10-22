class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :bio
      t.string :avatar

      t.timestamps
    end
  end
end
