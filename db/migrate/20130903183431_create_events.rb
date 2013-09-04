class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :source_id
      t.text   :area
      t.text   :description
      t.string :street
      t.string :zip_code
      t.date   :starts_at
      t.date   :ends_at
      t.text   :period
      t.text   :host
      t.string :email
      t.string :website
      t.text   :note
      t.timestamps
    end

    add_index :events, :source_id
  end
end
