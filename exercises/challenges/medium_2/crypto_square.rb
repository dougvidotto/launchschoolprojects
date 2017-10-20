class Crypto
  attr_reader :size, :plaintext_segments
  def initialize(text)
    @text = text.gsub(/[^a-zA-Z0-9]/, "").downcase
    @size = Math.sqrt(@text.size).ceil
    @plaintext_segments = create_plaintext_segments
  end

  def normalize_plaintext
    @text
  end

  def ciphertext
    normalize_ciphertext.gsub(" ", "")
  end

  def normalize_ciphertext
    plaintext_segments.each_with_object(Array.new(size){|_| ""}) do |segment, cipher|
      segment.chars.map.with_index {|char, idx| cipher[idx] += char}
    end.join(" ")
  end

  private

  def create_plaintext_segments
    @text.chars.each_slice(size).map {|slice| slice.join}
  end
end

crypto = Crypto.new('Vampires are people too!')
p crypto.normalize_ciphertext