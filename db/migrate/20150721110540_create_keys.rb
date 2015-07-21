class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :api_key, null: false
      t.integer :count, default: 0, maximum: 20
      t.belongs_to :user
    end
  end

end
