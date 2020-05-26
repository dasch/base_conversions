# Base Conversions

Proof of concept for mapping between [base16][1] and [base32][2] encodings.

When dealing with very large integers, it may not be possible to transmit them as _integers_. That is, the languages and protocols used may not support, say, 128 bit unsigned integers. Instead, we need to _encode_ the integer into a string that can be safely lugged around.

This project shows how to _map_ from one such encoding to another. Specifically, it shows how to map between base16 (also known as _hexadecimal_) and base32 (specifically, the Crockford specification).

Since the whole point of encoding to strings is that the integers may be too large to represent as native integers in a programming language, how can this be done then? Well, we can use the fact that 5 characters of base16 can be represented with exactly 4 characters of base32. When converting from base16 to base32, we divide the input string into blocks of 5 characters, starting from the right, for example:

```
4f03 826b0 1c6e2 8d824
    ^     ^     ^
```

The above input string is divided into 4 _blocks_, each of which is converted to base32:

```
KR3 G9NG 3HQ2 HP14
```

If any resulting base32 encoded block is less than 4 characters wide it is zero-padded to ensure fixed block size. Afterwards, the blocks can be joined and the correct base32 encoded string can be returned!

In practice, we first reverse the string, then chop off fixed-sized blocks, then correct the order within each block, before converting between the bases, correcting the order _between_ blocks, and joining the blocks. Easy peasy!

## Usage

```ruby
require "baseconvert"

BaseConvert.base16_to_base32("4f03826b01c6e28d824")
#=> "KR3G9NG3HQ2HP14"
```

[1]:	https://en.wikipedia.org/wiki/Hexadecimal
[2]:	https://www.crockford.com/base32.html