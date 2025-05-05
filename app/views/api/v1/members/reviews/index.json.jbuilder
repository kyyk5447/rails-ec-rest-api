json.reviews do
  json.array!(@reviews) do |review|
    json.id review.id
    json.title review.title
    json.comment review.comment
    json.rating review.rating
  end
end

json.totalPages @reviews.total_pages
json.totalCount @reviews.total_count
json.currentPage @reviews.current_page
json.nextPage @reviews.next_page
json.hasNext @reviews.next_page.present?
