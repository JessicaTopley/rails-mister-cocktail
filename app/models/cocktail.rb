class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_one_attached :photo
  validates :name, uniqueness: true
  validates :name, presence: true
  belongs_to :user

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

    def self.perform_search(keyword)
    if keyword.present?
      Cocktail.search_by_name(keyword)
    else
      Cocktail.all
    end
  end
end

