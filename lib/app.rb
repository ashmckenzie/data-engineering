get '/' do
  haml :index
end

post '/' do
  if f = params[:file][:tempfile]
    %w{ Purchaser Merchant Item Purchase }.each do |table|
      Kernel.const_get(table).truncate
    end

    f.read.split("\n").collect { |x| x.split("\t") }[1..-1].each do |r|
      purchaser = Purchaser.find_or_create(name: r[0].strip)
      item = Item.find_or_create(description: r[1].strip, price: r[2].to_f)
      merchant = Merchant.find_or_create(name: r[5].strip, address: r[4].strip)

      purchase = Purchase.create(purchaser: purchaser, item: item, 
        item_price_paid: item.price, item_count: r[3], merchant: merchant)
    end

    @rows = Purchase.all
    @total = Purchase.sum(:item_price_paid * :item_count)

    haml :index
  end
end