json.items do
  json.array!(@items) do |item|
    json.id item.id
    json.imageUrl item.image_url || ''
    json.name item.name
    json.description item.description
    json.price item.price
    json.stock item.stock
    json.createdAt item.created_at
  end
end

json.totalPages @items.total_pages
json.totalCount @items.total_count
json.currentPage @items.current_page
json.nextPage @items.next_page
json.hasNext @items.next_page.present?