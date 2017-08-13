class Santa
  attr_accessor :face, :x, :y

  def initialize
    @x, @y, @visited_coords = 0, 0, []
    @directions = [:n, :e, :s, :w]
  end

  def face
    @directions.first
  end

  def navigate(ins)
    ins.split(',').each do |cmd|
    cmd_dir, cmd_dist = Santa.parse_command(cmd)
      turn(cmd_dir)
      cmd_dist.times{ move_forward }
    end
    puts "I am #{@x.abs + @y.abs} blocks away."
    puts "I crossed a location twice at #{@first_visited} which is #{@first_visited[0].abs + @first_visited[1].abs} blocks away."
  end

  def turn(l_or_r)
    if(l_or_r == 'R')
      @directions.rotate!
    else
      @directions.rotate!(-1)
    end
  end

  def move_forward
    if face == :n
      @y = @y + 1
    elsif face == :s
      @y = @y - 1
    elsif face == :e
      @x = @x + 1
    else
      @x = @x - 1
    end
    @first_visited = [@x, @y] if already_visited?(@x, @y) && @first_visited.nil?
    @visited_coords << [@x, @y]
  end

  def already_visited?(x, y)
    @visited_coords.include?([x, y])
  end

  def to_s
    "I am at (#{@x},#{@y}) facing #{face}"
  end

  private

  def self.parse_command(cmd)
    cmd = cmd.strip
    return cmd[0], cmd[1..-1].to_i
  end

end

#Testing

ip = 'R3, L5, R2, L1, L2, R5, L2, R2, L2, L2, L1, R2, L2, R4, R4, R1, L2, L3, R3, L1, R2, L2, L4, R4, R5, L3, R3, L3, L3, R4, R5, L3, R3, L5, L1, L2, R2, L1, R3, R1, L1, R187, L1, R2, R47, L5, L1, L2, R4, R3, L3, R3, R4, R1, R3, L1, L4, L1, R2, L1, R4, R5, L1, R77, L5, L4, R3, L2, R4, R5, R5, L2, L2, R2, R5, L2, R194, R5, L2, R4, L5, L4, L2, R5, L3, L2, L5, R5, R2, L3, R3, R1, L4, R2, L1, R5, L1, R5, L1, L1, R3, L1, R5, R2, R5, R5, L4, L5, L5, L5, R3, L2, L5, L4, R3, R1, R1, R4, L2, L4, R5, R5, R4, L2, L2, R5, R5, L5, L2, R4, R4, L4, R1, L3, R1, L1, L1, L1, L4, R5, R4, L4, L4, R5, R3, L2, L2, R3, R1, R4, L3, R1, L4, R3, L3, L2, R2, R2, R2, L1, L4, R3, R2, R2, L3, R2, L3, L2, R4, L2, R3, L4, R5, R4, R1, R5, R3'
s = Santa.new.navigate(ip)
