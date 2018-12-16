require 'benchmark'

input = File.read("./input.txt").split(/ /).map(&:to_i)

def parse_nodes(input)
  child_nodes, metadata_size = input[0..1]

  start_of_children_index = 2

  start_index = start_of_children_index
  end_index = -1

  children_sums = Hash.new(0)
  1.upto(child_nodes) do |i|
    metadata_sum, child_length = parse_nodes(input[start_index..end_index])
    children_sums[i] = metadata_sum
    start_index += child_length
  end

  metadata = input[start_index...(start_index + metadata_size)]

  metadata_sum = child_nodes.zero? ? metadata.sum : metadata.map { |entry| children_sums[entry] }.sum

  [metadata_sum, start_index + metadata_size]
end

sum = 0
Benchmark.bm do |x|
  x.report { sum = parse_nodes(input)[0] }
end

puts sum
