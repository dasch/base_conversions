require "base32/crockford"

module Conversions
  extend self

  def base16_to_base32(input)
    input.
      chars.
      reverse.
      each_slice(5).
      map {|slice| slice.reverse.join }.
      map(&:hex).
      map {|hex| Base32::Crockford.encode(hex) }.
      map {|s| s.rjust(4, "0") }.
      reverse.
      join.
      gsub(/^0+(.)/, '\1') # strip leading zeros
  end

  def base32_to_base16(input)
    input.
      chars.
      reverse.
      each_slice(4).
      map {|slice| slice.reverse.join }.
      map {|base32| Base32::Crockford.decode(base32) }.
      map {|n| n.to_s(16) }.
      map {|s| s.rjust(5, "0") }.
      reverse.
      join.
      gsub(/^0+(.)/, '\1') # strip leading zeros
  end
end
