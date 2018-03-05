defmodule Huffman do
  def sample do
    'foofoaofab'
  end

  def text, do: 'this is something we should encode'

  def main do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
#    decode = decode_table(tree)
    #text = text()
    #seq = encode(text, encode)
    #decode(seq, decode)
  end

  def tree(sample) do
    list = freq(sample, [])
    IO.inspect (list)
    sorted = sort(list)
    IO.inspect sorted
    huffman_tree(sorted)
  end

  def freq(sample) do
    {sample,[]}
  end
  def freq([], list) do
    list
  end
  def freq([char|rest], list) do
    freq(rest, update(char, list))
  end

  def update(char, []) do
    [{char, 1}]
  end
  def update(char, [{char, n} | list]) do
    [{char, n + 1} | list]
  end
  def update(char, [element | list]) do
    [element | update(char, list)]
  end

  def sort(list) do
    Enum.sort(list, fn({_,x},{_,y}) -> x < y end)
  end

  def huffman_tree([{tree, _}]), do: tree
  def huffman_tree([{a, af}, {b, bf} | rest]) do
   huffman_tree(insert({{a, b}, af + bf}, rest))
  end

  def insert({a, af}, []), do: [{a, af}]
  def insert({a, af}, [{b, bf} | rest]) when af < bf do
   [{a, af}, {b, bf} | rest]
  end
  def insert({a, af}, [{b, bf} | rest]) do
   [{b, bf} | insert({a, af}, rest)]
  end

  def encode_table(tree) do
    IO.inspect tree
  end

#  def decode_table(tree) do
#  end

#  def encode(text, table) do
#  end

#  def decode(seq, tree) do
#  end
end
