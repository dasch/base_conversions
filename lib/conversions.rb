require "base32/crockford"

module Conversions
  extend self

  def base16_to_base32(input)
    blocks_of_size(input, 5).
      map(&:hex).
      map {|hex| Base32::Crockford.encode(hex) }.
      map {|s| s.rjust(4, "0") }.
      reverse.
      join.
      gsub(/^0+(.)/, '\1') # strip leading zeros
  end

  def base32_to_base16(input)
    blocks_of_size(input, 4).
      map {|base32| Base32::Crockford.decode(base32) }.
      map {|n| n.to_s(16) }.
      map {|s| s.rjust(5, "0") }.
      reverse.
      join.
      gsub(/^0+(.)/, '\1') # strip leading zeros
  end

  private

  # Takes an input String and chops it up into blocks of the specified
  # size starting *from the right*. That means that the return value will
  # be an Array of String values representing the blocks, in reverse order.
  #
  # Examples
  #
  #   blocks_of_size("ABCDEFG", 3)
  #   #=> ["EFG", "BCD", "A"]
  #
  def blocks_of_size(input, block_size)
    input.
      chars.
      reverse.
      each_slice(block_size).
      map {|slice| slice.reverse.join }
  end
end
