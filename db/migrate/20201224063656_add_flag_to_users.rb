class AddFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :flag, :boolean, default: false
  end
end
