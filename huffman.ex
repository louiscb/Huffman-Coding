defmodule Huffman do
  def sample do
    'The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog.'
  end

  def text, do: 'the hello world '

  def main do
    text = text()
    IO.write ("Original text: '#{text}' \nOriginal Encoding: ")
    IO.inspect text, charlists: :as_lists
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = encode_table(encode, [])
    encoded_text = encode(text, encode)
    IO.write ("Huffman Encoded text: ")
    IO.inspect encoded_text
    decode(encoded_text, encode)
  end

  def tree(sample) do
    list = freq(sample, [])
    sorted = sort(list)
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
    encode_table(tree, [])
  end
  def encode_table({left, right}, table) do
    nodeLeft = encode_table(left, [0 | table])
    nodeRight = encode_table(right, [1 | table])
    nodeLeft ++ nodeRight
  end
  def encode_table(node, table) do
    [{node, Enum.reverse(table)}]
  end

  def decode_table(tree) do
  end

  def encode([], _), do: []
  def encode([head|tail], table) do
    #Receives a list of tuples and returns the first
    #tuple where the item at position in the tuple
    #matches the given key
    {_,code} = List.keyfind(table, head, 0)
    code ++ encode(tail, table)
  end

  def decode(code, table) do
    decode(code, table, [])
  end
  def decode([], _, sequence), do: sequence
  def decode(code, table, sequence) do
    {char, length} = decode_by_char(code, table, [])
    code = Enum.take(code, length-length(code))
    sequence = sequence ++ [char]
    decode(code, table, sequence)
  end
  def decode_by_char([head|tail], table, list) do
    list = list ++ [head]
    case List.keyfind(table, list, 1) do
      {char, _} -> {char, length(list)}
      nil -> decode_by_char(tail, table, list)
    end
  end
end
