class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|

      t.timestamps null: false
      t.integer :accountnumber
      t.string :name
      t.string :status
      t.string :email
      t.date :startdate
      t.integer :initialterm
      t.integer :renewalterm
      t.date :enddate
      t.date :createdate
      t.string :product
      t.string :productrateplan
      t.string :rateplanperiod
      t.string :rateplantype
      t.string :rateplancreatedate
    end
  end
end
