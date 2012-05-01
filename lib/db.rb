DB = Sequel.sqlite('./db/app.db', :loggers => [Logger.new($stdout)])

class Purchaser < Sequel::Model
  one_to_many :purchases
end

class Merchant < Sequel::Model
  one_to_many :purchases
end

class Item < Sequel::Model
  one_to_many :purchases
end

class Purchase < Sequel::Model
  many_to_one :purchaser
  many_to_one :item
  many_to_one :merchant  
end

DB.create_table! :purchasers do
  primary_key :id
  String :name
end

DB.create_table! :merchants do
  primary_key :id
  String :name
  String :address  
end

DB.create_table! :items do
  primary_key :id
  String :description
  Float :price  
end

DB.create_table! :purchases do
  primary_key :id
  Integer :purchaser_id
  Integer :item_id
  Float :item_price_paid   # the price paid for the item at the time
  Float :item_count
  Integer :merchant_id
end