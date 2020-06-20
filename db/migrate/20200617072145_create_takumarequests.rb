class CreateTakumarequests < ActiveRecord::Migration[5.2]
  def change
    create_table :takumarequests do |t|
      t.integer :join_user_id
      t.integer :mid_user_id
      t.integer :takumari_id

      t.timestamps
    end
  end
end
