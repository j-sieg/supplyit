[
  'Aggregates',
  'Hollow Blocks',
  'Cement',
  'Glass',
  'Paints',
  'Pipes',
  'Steels',
  'Stones',
  'Tiles',
  'Timber'
].each do |category_name|
  Category.first_or_create!(name: category_name)
end

if Rails.env.development?
  Seller.find_each do |seller|
    10.times do
      seller.products.create!(
        name: Faker::Construction.material,
        price: Faker::Commerce.price(range: 500..10000),
        location: Faker::TvShows::Simpsons.location,
        categories: Category.order('RANDOM()').limit(3)
      )
    end
  end
  puts "Generated 10 products for each Seller"
end
