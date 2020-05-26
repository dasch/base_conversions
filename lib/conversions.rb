require "base32/crockford"

module Conversions
  extend self

  def base16_to_base32(input)
    blocks_of_size(input, 5).
      map {|block| convert_block_16_to_32(block) }.
      reverse.
      join.
      gsub(/^0+(.)/, '\1') # strip leading zeros
  end

  def base32_to_base16(input)
    blocks_of_size(input, 4).
      map {|block| convert_block_32_to_16(block) }.
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

  # Converts a base16 string "block" to a base32 string.
  def convert_block_16_to_32(block)
    n = block.hex # convert the base16 string to an integer.
    base32 = Base32::Crockford.encode(n) # convert the integer to base32.
    base32.rjust(4, "0") # pad with leading zeros.
  end

  # Converts a base32 string "block" to a base16 string.
  def convert_block_32_to_16(block)
    n = Base32::Crockford.decode(block) # convert the base32 string to an integer.
    base16 = n.to_s(16) # convert the integer to base16.
    base16.rjust(5, "0") # pad with leading zeros.
  end
end
