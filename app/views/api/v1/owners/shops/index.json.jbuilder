json.shops do
  json.array! @shops do |shop|
    json.id shop.id
    json.categories shop.shop_categories do |category|
      json.id category.id
      json.name category.name
    end
    json.imageUrl shop.image_url || ''
    json.name shop.name
    json.description shop.description
    json.createdAt shop.created_at
  end
end

json.totalPages @shops.total_pages
json.totalCount @shops.total_count
json.currentPage @shops.current_page
json.nextPage @shops.next_page
json.hasNext @shops.next_page.present?
