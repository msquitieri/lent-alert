class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :source
      t.integer :height
      t.integer :width
      t.references :email, index: true

      t.timestamps null: false
    end
    add_foreign_key :images, :emails
  end
end
