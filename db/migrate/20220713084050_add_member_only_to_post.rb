class AddMemberOnlyToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :member_only, :boolean, default: false, null: false
  end
end
