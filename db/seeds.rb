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
  Category.find_or_create_by!(name: category_name)
end
