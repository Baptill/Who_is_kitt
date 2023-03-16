class AddBatchToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :batch, :string
  end
end
