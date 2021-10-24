class AddIndexToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_index :favorites, [:question_id, :user_id], unique: true
    #Ex:- add_index("admin_users", "username")
  end
end
