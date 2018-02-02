defmodule Huffman do
  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text, do: 'this is something we should encode'

  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end

  def tree(sample) do
    freq(sample, [])
    sorted = sort(freq)
    huffman_tree(sorted)
  end

  def freq([], freq) do freq end
  def freq([char|rest], freq) do
    freq(rest, update(char, freq))
  end

  def huffman_tree(freq) do

  end

  def update(char, []) do [{char, 1}] end def

  def encode_table(tree) do
  end

  def decode_table(tree) do
  end

  def encode(text, table) do
  end

  def decode(seq, tree) do
  end
end
