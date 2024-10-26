class Page < ApplicationRecord
  belongs_to :user

  validates :title,
            presence: true,
            uniqueness: true

  validates :content,
            presence: true

  before_validation :make_slug

  scope :published, -> { where(published: true) }

  scope :ordered, -> { order(created_at: :desc) }

  # scope :by_term, ->(term) { where('content LIKE ?', "%#{term}%") } # TODO: Implement

  scope :by_term, ->(term) do
    term.gsub!(/[^-\w ]/, '')
    terms = term.include?(' ') ? term.split : [term]
    pages = Page

    terms.each do |t|
      pages = pages.where('content ILIKE ?', "%#{t}%")
    end

    pages
  end

  private

  def make_slug
    # print "Generated slug: #{title}"
    return if title.blank?

    self.slug = title
                .downcase
                .gsub(/[_ ]/, '-')
                .gsub(/[^-a-z0-9+]/, '')
                .gsub(/-{2,}/, '-')
                .gsub(/^-/, '')
                .chomp('-')
  end
end
