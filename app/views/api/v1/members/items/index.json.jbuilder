json.items @items do |item|
  json.id item.id
  json.categories item.item_categories do |category|
    json.id category.id
    json.name category.name
  end
  json.imageUrl item.image_url || ''
  json.name item.name
  json.description item.description
  json.price item.price
  json.stock item.stock
  json.createdAt item.created_at
end

json.totalPages @items.total_pages
json.totalCount @items.total_count
json.currentPage @items.current_page
json.nextPage @items.next_page
json.hasNext @items.next_page.present?
