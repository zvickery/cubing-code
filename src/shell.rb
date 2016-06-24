#!/usr/bin/env ruby

require_relative './cube'
require_relative './cube_moves'

# Shell interface for manipulating cubes interactively
class CubeCli
  PROMPT = '> '.freeze
  HELP_TEXT = "You'll just have to support yourself!".freeze
  NO_CUBE = "Cube not defined.  Try 'c 3' to make one.".freeze

  def run_cli
    loop do
      command, *params = read_cli_command
      next unless command

      case command
      when /\Ahelp\z/i
        puts HELP_TEXT
      when /\Aexit\z/i
        break
      when /\Acube\z/i, /\Ac\z/i
        cube(*params)
      when /\Amove\z/i, /\Am\z/i
        move(*params)
      when /\Adump\z/i, /\Ad\z/i
        dump
      else puts 'Invalid command' if command
      end
    end
  rescue Interrupt
    puts
  end

  def read_cli_command
    PROMPT.display
    input = gets
    raise Interrupt, 'EOF detected' if input.nil?

    if !input
      puts
      return false
    else
      input.chomp.split(/\s/)
    end
  end

  def check_cube
    if @cube
      true
    else
      puts NO_CUBE
      false
    end
  end

  def cube(dimension)
    @cube = Cube.new(dimension.to_i)
    @moves = CubeMoves.new(@cube, Logger::WARN)
    puts "Created cube with dimension #{dimension}"
    dump
  end

  def move(*moves)
    return unless check_cube
    begin
      @moves.make_move(moves)
      dump
    rescue ArgumentError => e
      puts e.message
    end
  end

  def dump
    return unless check_cube
    puts @cube.dump_cube
  end
end
