json.items do
  json.array!(@items) do |item|
    json.id item.id
    json.imageUrl item.image_url
    json.name item.name
    json.description item.description
    json.price item.price
    json.stock item.stock
    json.status item.status_before_type_cast
    json.createdAt item.created_at

    json.shop do
      json.id item.shop.id
      json.name item.shop.name
      json.description item.shop.description
    end
  end
end

json.totalPages @items.total_pages
json.totalCount @items.total_count
json.currentPage @items.current_page
json.nextPage @items.next_page
json.hasNext @items.next_page.present?
