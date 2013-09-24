class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    remove_column :beers, :style
    add_column :beers, :style_id, :integer
  end
end
