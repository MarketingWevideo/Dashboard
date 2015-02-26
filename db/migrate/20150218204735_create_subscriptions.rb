class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|

      t.timestamps null: false
      t.string :accountnumber
      t.string :accountname
      t.integer :accountbalance
      t.integer :accountmrr


      t.string :ownerfirstname
      t.string :ownerlastname
      t.string :owneremail

      t.string :subscriptionstatus
      t.date :subscriptionstartdate
      t.date :subscriptionendate
      t.date :subscriptioncanceldate
      t.string :subscriptionid
      t.date :contracteffectivedate

      t.date :startdate
      t.integer :initialterm
      t.integer :renewalterm
      t.date :enddate
      t.date :createdate
       t.integer :mrr

      t.string :product
      t.string :productrateplan
      t.string :rateplanperiod
      t.string :rateplantype
      t.string :rateplancreatedate
      t.string :rateplanchargeid
      t.string :amendment_type      
    end
  end
end
