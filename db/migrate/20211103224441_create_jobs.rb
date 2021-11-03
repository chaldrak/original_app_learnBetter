class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :content
      t.string :location
      t.date :deadline

      t.timestamps
    end
  end
end
