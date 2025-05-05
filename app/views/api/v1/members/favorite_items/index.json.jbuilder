json.favoriteItems do
  json.array! @favorite_items do |item|
    json.id item.id
    json.imageUrl item.image_url || ''
    json.name item.name
    json.description item.description
    json.price item.price
    json.stock item.stock
    json.createdAt item.created_at
  end
end

json.totalPages @favorite_items.total_pages
json.totalCount @favorite_items.total_count
json.currentPage @favorite_items.current_page
json.nextPage @favorite_items.next_page
json.hasNext @favorite_items.next_page.present?
