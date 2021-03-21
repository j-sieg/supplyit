Seller.find_each do |seller|
  10.times do
    seller.products.create!(
      name: Faker::Construction.material,
      price: Faker::Commerce.price(range: 500..10000),
      location: Faker::TvShows::Simpsons.location
    )
  end
end
