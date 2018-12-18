

class Marbles
  attr_reader :col, :current_index, :players_scores

  def initialize
    @col = [0]
    @current_index = 0
    @players_scores = Hash.new(0)
  end

  def interesting
    []
  end

  def add(marble, by: )
    if (marble % 23).zero?
      players_scores[by] += marble
      position = (current_index - 7) % col.size
      removed_marble = col.slice!(position)
      puts "marble #{marble}" if interesting.include? marble
      puts "player #{by}" if interesting.include? marble
      players_scores[by] += removed_marble

      @current_index = position
      puts "marbles #{print} \n\n" if interesting.include? marble
    else
      puts "marble #{marble}" if interesting.include? marble
      puts "player #{by}" if interesting.include? marble
      puts "marbles before #{print}" if interesting.include? marble
      position = (current_index + 1) % col.size
      @col.insert(position + 1, marble)
      
      @current_index = position + 1
      puts "marbles #{print} \n\n" if interesting.include? marble
    end
  end

  def next1
    col[current_index + 1]
  end

  def next2
    col[current_index + 2]
  end

  def previous7
    col[current_index - 7]
  end

  def [](index)
    i = index % col.size
    col[i]
  end

  def print
    col.map.with_index do |marble, index|
      if index == current_index
        "(#{marble})"
      else
        marble
      end
    end.join(' ')
  end
end

marbles = Marbles.new

highest_marble = 71058 * 100
number_of_players = 411
marble = 1

loop do
  1.upto(number_of_players) do |player|
    marbles.add(marble, by: player)

    marble += 1
    break if marble == highest_marble + 1
  end
  break if marble == highest_marble + 1
end

#puts "scores #{marbles.players_scores}"

puts marbles.players_scores.to_a.sort! { |player1, player2| player1[1] <=> player2[1] }[-1][1]
