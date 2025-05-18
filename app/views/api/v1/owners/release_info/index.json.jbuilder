json.releaseInfo do
  json.array!(@release_info) do |release_info|
    json.id release_info.id
    json.title release_info.title
    json.body release_info.body
    json.status release_info.status_before_type_cast
    json.shop do
      json.id release_info.shop.id
      json.name release_info.shop.name
    end
  end
end

json.totalPages @release_info.total_pages
json.totalCount @release_info.total_count
json.currentPage @release_info.current_page
json.nextPage @release_info.next_page
json.hasNext @release_info.next_page.present?
