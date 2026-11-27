class Link < ApplicationRecord
  RESERVED_CODES = %w[links rails assets admin api up locale].freeze

  has_many :click_events, dependent: :destroy

  attribute :clicks_count, :integer, default: 0

  validates :original_url, presence: true,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: :invalid_url }
  validates :short_code, presence: true, uniqueness: true,
            length: { in: 4..15 },
            exclusion: { in: RESERVED_CODES, message: :reserved_code },
            format: { with: /\A[a-zA-Z0-9_-]+\z/, message: :invalid_code_format }

  before_validation :generate_short_code, on: :create

  private

  def generate_short_code
    return if short_code.present?

    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    loop do
      self.short_code = Array.new(6) { chars.sample }.join
      break unless Link.exists?(short_code: short_code)
    end
  end
end
