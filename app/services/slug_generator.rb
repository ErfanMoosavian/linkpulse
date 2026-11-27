class SlugGenerator
  ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".chars.freeze

  def self.call(length: 7)
    new(length: length).call
  end

  def initialize(length: 7)
    @length = length
  end

  def call
    loop do
      slug = Array.new(@length) { ALPHABET.sample }.join
      return slug unless Link.exists?(slug: slug)
    end
  end
end
