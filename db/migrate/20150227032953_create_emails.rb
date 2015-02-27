class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :subject
      t.string :headline
      t.string :body
      t.string :special

      t.timestamps null: false
    end
  end
end
