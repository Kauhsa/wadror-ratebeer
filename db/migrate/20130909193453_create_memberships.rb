class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user
      t.references :beer_club

      t.timestamps
    end
    add_index :memberships, :user_id
    add_index :memberships, :beer_club_id
  end
end
