class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :cluster_id, :string
    add_column :users, :delivery_person_id, :string
  end
end
