require 'benchmark'

input = File.read("./input.txt").split(/ /).map(&:to_i)

def parse_nodes(input)
  #puts "input #{input}"
  child_nodes, metadata_size = input[0..1]

  start_of_children_index = 2

  start_index = start_of_children_index
  end_index = -1

  #puts "child nodes #{child_nodes}\n\n"
  children_sum = 0
  child_nodes.times do
    metadata_sum, child_length = parse_nodes(input[start_index..end_index])
    children_sum += metadata_sum
    start_index += child_length
  end

  #puts "metadata start index #{start_index}"
  metadata = input[start_index...(start_index + metadata_size)]
  #puts "metadata size #{metadata_size} metadata #{metadata}"

  [metadata.sum + children_sum, start_index + metadata_size]
end

sum = 0
Benchmark.bm do |x|
  x.report { sum = parse_nodes(input)[0] }
end

puts sum

