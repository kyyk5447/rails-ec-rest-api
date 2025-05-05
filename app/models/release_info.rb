class ReleaseInfo < ApplicationRecord
  belongs_to :shop

  enum status: {
    unpublished: 0,
    draft: 1,
    published: 2,
  }

  validates :title, presence: true
  validates :body, presence: true
  validates :status, inclusion: { in: statuses.keys }
end
