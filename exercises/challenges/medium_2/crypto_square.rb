# Algorithm
# Dividing into squares
# pick up text and iterate through its characters
# when index reaches the size position we add those characters until that position into an array

class Crypto
  attr_reader :size, :plaintext_segments
  def initialize(text)
    @text = text.gsub(/\W/, "").downcase
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
    cipher_position = 0
    cipher_segments = []
    loop do
      break if cipher_position == size
      position = 0
      cipher_segment = ""
      loop do
        break if position == plaintext_segments.size
        cipher_segment += plaintext_segments[position][cipher_position].to_s
        position += 1
      end
      cipher_segments << cipher_segment
      cipher_position += 1
    end
    cipher_segments.join(" ")
  end

  private

  def create_plaintext_segments
    position = 0
    segments = []
    loop do
      break if position >= @text.size
      segments << @text[position...position + size]
      position += size
    end
    segments
  end
end