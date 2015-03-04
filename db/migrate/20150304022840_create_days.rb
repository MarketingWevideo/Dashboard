class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|

      t.timestamps null: false
      t.date :daydate
      t.string :productname
      t.integer :newsubs
      t.integer :churnedsubs
      t.string :plan_period
      t.integer :mrrnew
      t.integer :mrrchurn
    end
  end
end
