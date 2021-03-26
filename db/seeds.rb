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
