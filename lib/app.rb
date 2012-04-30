require 'logger'

DB = Sequel.sqlite('./db/app.db', :loggers => [Logger.new($stdout)])

DB.create_table! :purchases do
  primary_key :id
  String :purchaser_name
  String :item_description
  Float :item_price
  Float :purchase_count
  String :merchant_name
  String :merchant_address
end

get '/' do
  haml :index
end

post '/' do
  if f = params[:file][:tempfile]

    purchases = DB[:purchases]
    purchases.truncate

    f.read.split("\n").collect { |x| x.split("\t") }[1..-1].each do |r|
      purchases.insert(
        :purchaser_name => r[0],
        :item_description => r[1],
        :item_price => r[2],
        :purchase_count => r[3],
        :merchant_name => r[5],
        :merchant_address => r[4],
      )
    end

    @rows = purchases.all
    @total = purchases.sum(:item_price * :purchase_count)

    haml :index
  end
end