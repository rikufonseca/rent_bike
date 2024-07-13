class CreateFavories < ActiveRecord::Migration[7.0]
  def change
    create_table :favories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bike, null: false, foreign_key: true

      t.timestamps
    end
  end
end
