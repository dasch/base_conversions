require "base32/crockford"

module BaseConversions
  extend self

  def base16_to_base32(input)
    in_blocks_of_size(input, 5) {|block| convert_block_16_to_32(block) }
  end

  def base32_to_base16(input)
    in_blocks_of_size(input, 4) {|block| convert_block_32_to_16(block) }
  end

  private

  # Takes an input String and chops it up into blocks of the specified
  # size starting *from the right*. That means that the return value will
  # be an Array of String values representing the blocks, in reverse order.
  #
  # For example, with a block size of 3:
  #
  #   "ABCDEFG" => ["EFG", "BCD", "A"]
  #
  # The method then yields each block, and stiches the results back together,
  # correcting the order between blocks.
  #
  # Returns a String.
  def in_blocks_of_size(input, block_size)
    input.
      chars.
      reverse.
      each_slice(block_size).
      map {|slice| yield slice.reverse.join }.
      reverse.
      join.
      gsub(/^0+(.)/, '\1') # strip leading zeros
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
