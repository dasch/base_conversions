require 'rantly'
require 'rantly/rspec_extensions'
require 'rantly/shrinks'

require_relative "../lib/conversions"

RSpec.describe Conversions do
  include Conversions

  it "converts back and forth between base 16 and 32" do
    property_of { i = integer; guard i >= 0; i }.check {|i|
      hex = i.to_s(16)
      base32 = base16_to_base32(hex)
      base16 = base32_to_base16(base32)

      expect(base16).to eq hex
    }
  end

  describe "base16_to_base32" do
    it "converts valid base16 numbers" do
      expect(base16_to_base32("0")).to eq "0"
      expect(base16_to_base32("10")).to eq "G"
      expect(base16_to_base32("1010")).to eq "40G"
      expect(base16_to_base32("101010")).to eq "1040G"
    end

    it "gives the same result as with using an int intermediary" do
      property_of { i = integer; guard i >= 0; i }.check {|i|
        hex = i.to_s(16)
        base32 = base16_to_base32(hex)

        expect(Base32::Crockford.decode(base32)).to eq i
      }
    end
  end
end
