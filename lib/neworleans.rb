#!/usr/bin/env ruby
#
# Written by Webster Avosa

module MISSIONGAME
  MAP_WIDTH = 64
  MAP_HEIGHT = 14

  MAP_KEY_TREE = "\u2663"
  MAP_KEY_WATER = "\u2248"
  MAP_KEY_GRASS = "\u2588"
  MAP_KEY_MOUNTAIN = "\u25B2"
  MAP_KEY_ENEMY = "\u263A"
  MAP_KEY_WITCH = "\u263B"
  MAP_KEY_PLAYER = "\u1330"

  # Weighted
  MAP_POSSIBLE_KEYS = [
    MAP_KEY_TREE,
    MAP_KEY_TREE,
    MAP_KEY_TREE,
    MAP_KEY_TREE,
    MAP_KEY_WATER,
    MAP_KEY_GRASS,
    MAP_KEY_MOUNTAIN,
    MAP_KEY_ENEMY,
    MAP_KEY_ENEMY
  ]

  # Make grass more common
  32.times.each { MAP_POSSIBLE_KEYS << MAP_KEY_GRASS }

  MAP_WITCH_X = MAP_WIDTH
  MAP_WITCH_Y = 1

  class NewOrleans
    attr_reader :the_map

    def initialize
      # Set initial New Orleans map
      generate_map
    end

    def get_width
      MAP_WIDTH
    end

    def get_height
      MAP_HEIGHT
    end

    # Return map data in a display format
    def get_map(args)
      player = args[:player]
      buffer = []
      x = 1
      y = 1
      @the_map.each do |row|
        tmp_row = []
        x = 1
        row.each do |col|
          placed = 0

          # Place WITCH
          if x == MAP_WITCH_X && y == MAP_WITCH_Y
            tmp_row << MAP_KEY_WITCH.colorize(color: :white, background: :red)
            placed = 1
          end

          # If player is here, display them
          if x == player.x && y == player.y
            tmp_row << MAP_KEY_PLAYER.colorize(color: :red, background: :white)
            placed = 1
          end

          # If we haven't already placed the Player, run through the rest of the options
          if placed == 0
            case col
            when MAP_KEY_TREE
              tmp_row << col.colorize(color: :light_green, background: :green)
            when MAP_KEY_GRASS
              tmp_row << col.colorize(color: :green, background: :green)
            when MAP_KEY_WATER
              tmp_row << col.colorize(color: :white, background: :blue)
            when MAP_KEY_MOUNTAIN
              tmp_row << col.colorize(color: :yellow, background: :green)
            when MAP_KEY_ENEMY
              tmp_row << col.colorize(color: :red, background: :green)
            end
          end
          x += 1
        end
        buffer << tmp_row
        y += 1
      end

      buffer
    end

    # Check the current area on the map and describe it
    def check_area(args)
      player = args[:player]
      ui = args[:ui]
      story = args[:story]
      x = player.x
      y = player.y
      current_area = @the_map[y - 1][x - 1]
      case current_area
      when MAP_KEY_TREE
        ui.draw_frame({text: story.area_tree})
      when MAP_KEY_WATER
        ui.draw_frame({text: story.area_water})
      when MAP_KEY_MOUNTAIN
        ui.draw_frame({text: story.area_mountain})
      when MAP_KEY_ENEMY
        ui.draw_frame({text: story.area_enemy})
        return false
      end
      true
    end

    private

    def new_line
      print "\n"
    end

    # Create a random new orleans map
    def generate_map
      tmp_map = []

      # Step through MAX_HEIGHT times
      MAP_HEIGHT.times do
        tmp_row = []
        MAP_WIDTH.times { tmp_row << MAP_POSSIBLE_KEYS.sample }

        # Add our assembled row to the map
        tmp_map << tmp_row
        tmp_row = nil
      end
      @the_map = tmp_map
    end
  end
end
