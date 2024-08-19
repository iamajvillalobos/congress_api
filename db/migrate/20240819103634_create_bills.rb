class CreateBills < ActiveRecord::Migration[7.2]
  def change
    create_table :bills do |t|
      t.integer :congress
      t.string :number
      t.string :bill_type
      t.string :title
      t.string :origin_chamber
      t.string :origin_chamber_code
      t.date :update_date
      t.datetime :update_date_including_text
      t.string :url
      t.json :latest_action

      t.timestamps
    end

    add_index :bills, :congress
    add_index :bills, :bill_type
    add_index :bills, :update_date
    add_index :bills, :url, unique: true
  end
end
