class AddCulumnToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :select, :boolean, default: false
  end
end
