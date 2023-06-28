class AddUserReferenceToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :author, oreign_key: { to_table: 'users' }
  end
end
