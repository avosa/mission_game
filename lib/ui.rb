#!/usr/bin/env ruby
#
# Written by Webster Avosa
#

module MISSIONGAME
  UI_FRAME_HORIZONTAL = "\u2501"
  UI_FRAME_VERTICAL = "\u2503"
  UI_FRAME_UPPER_LEFT = "\u250F"
  UI_FRAME_LOWER_LEFT = "\u2517"
  UI_FRAME_UPPER_RIGHT = "\u2513"
  UI_FRAME_LOWER_RIGHT = "\u251B"

  UI_COPYRIGHT = "\u00A9"
  UI_EMAIL = "\u2709"
  UI_ARROW = "\u2712"

  class UI
    # Clear the screen
    def clear
      print "\e[H\e[2J"
    end

    def display_map(args)
      map = args[:map]
      new_line
      draw_frame({text: map})
      new_line
    end

    def help
      new_line
      print "Valid Commands".light_green
      new_line(2)
      print UI_ARROW.light_yellow + " " + "right, r, ".light_white +
        ++" - Move right/east"
      new_line
      print UI_ARROW.light_yellow + " " + "backward, b, ".light_white +
        ++" - Move backward/south"
      new_line
      print UI_ARROW.light_yellow + " " + "left, l, ".light_white +
        ++" - Move left/west"
      new_line
      print UI_ARROW.light_yellow + " " + "forward, f, ".light_white +
        ++" - Move forward/north"
      new_line
      print UI_ARROW.light_yellow + " " + "map, m".light_white + " - Display map"
      new_line
      print UI_ARROW.light_yellow + " " + "where".light_white +
        " - Describe current surroundings"
      new_line
      print UI_ARROW.light_yellow + " " + "name".light_white +
        " - Reminds player their name"
      new_line
      print UI_ARROW.light_yellow + " " + "a, attack".light_white +
        " - Attack (only in combat)"
      new_line
      print UI_ARROW.light_yellow + " " + "enemy".light_white +
        " - Display information about your enemy"
      new_line
      print UI_ARROW.light_yellow + " " +
        "points, score, status, info".light_white +
        " - Display points (score)"
      new_line
      print UI_ARROW.light_yellow + " " + "clear, cls".light_white +
        " - Clears the screen"
      new_line
      print UI_ARROW.light_yellow + " " + "q, quit, exit".light_white +
        " - Quits the MISSIONGAME"
      new_line
    end

    def points(args)
      player = args[:player]
      print "You currently have " + player.points.to_s.light_white + " points."
      new_line
    end

    def enemy_info(args)
      player = args[:player]
      enemy = player.current_enemy
      print enemy.name.light_red + " has " + enemy.str.to_s.light_white +
        " strength and " + enemy.lives.to_s.light_white + " lives."
      new_line
    end

    def player_info(args)
      player = args[:player]
      print "You have " + player.lives.to_s.light_white + " lives and have " +
        player.points.to_s.light_white + " points."
      new_line
    end

    # Ask user a question. A regular expression filter can be applied.
    def ask(question, filter = nil)
      if filter
        match = false
        answer = nil
        while match == false
          print UI_ARROW.red + question.light_white + " "
          answer = gets.chomp
          if answer.match(filter)
            return answer
          else
            print "Sorry, please try again.".red
            new_line
            new_line
          end
        end
      else
        print "\u2712 ".red + question.light_white + " "
        gets.chomp

      end
    end

    # Display welcome
    def welcome
      text = []
      text <<
        "This is a text adventure game inspired by the movie series ".white +
          "The Originals".light_green
      text <<
        "Written by: ".white +
          "Webster Avosa".light_green
      text <<
        "Copyright " + UI_COPYRIGHT +
          " Webster Avosa, All Rights Reserved.".white
      text << "Licensed under MIT.".white
      text <<
        "Contact me ".white + UI_EMAIL.light_white +
          " websterb17@gmail.com".white
      draw_frame({text: text})
      new_line
    end

    # Prints a new line. Optinally can print multiple lines.
    def new_line(times = 1)
      times.times { print "\n" }
    end

    # Draw text surrounded in a nice frame
    def draw_frame(args)
      # Figure out width automatically
      text = args[:text]
      width = get_max_size_from_array(text)
      draw_top_frame(width)
      text.each do |t|
        t_size = get_real_size(t)
        draw_vert_frame_begin
        if t.is_a?(Array)
          t.each { |s| print s }
        else
          print t
        end
        (width - (t_size + 4)).times { print " " }
        draw_vert_frame_end
        new_line
      end
      draw_bottom_frame(width)
    end

    def display_version
      puts " Version " + MISSIONMISSIONGAME_VERSION.light_white
      new_line
    end

    def not_found
      print "Command not understood. Use the " + "help or h".red +
        " to see available commands.".light_white
      new_line
    end

    def show_location(args)
      player = args[:player]
      print "You are currently on row " + player.y.to_s.light_white +
        ", column " + player.x.to_s.light_white
      new_line
      print "Use the " + "map".light_white + " command to see the map."
      new_line
    end

    def cannot_travel_combat
      puts "You're in a war with the vampires! Fight for your life to proceed or else your're being feasted on!"
    end

    def not_in_combat
      puts "No vampire has attacked you just yet."
    end

    def quit
      new_line
      print "You abandoned your journey to getting answers to all of your many unaswered questions."
        .red
      new_line(2)
    end

    def get_cmd
      print "Type ".white + "help".light_white + " for possible commands.\n"
      print "\u2712 ".red + "Your command? ".light_white
      gets.chomp.downcase
    end

    def out_of_bounds
      print "x".red + " Requested move out of bounds."
      new_line
    end

    def display_name(args)
      player = args[:player]
      print "You are " + player.name.light_white +
        ". Have you forgotten your own name?"
      new_line
    end

    def player_dead(args)
      story = args[:story]
      new_line
      text = story.player_dead
      draw_frame(text: text)
      new_line
    end

    def enemy_greet(args)
      enemy = args[:enemy]
      print enemy.name.light_white + " attacks!"
      new_line
    end

    private

    def draw_vert_frame_begin
      print UI_FRAME_VERTICAL.yellow + " "
    end

    def draw_vert_frame_end
      print " " + UI_FRAME_VERTICAL.yellow
    end

    def draw_top_frame(width)
      print UI_FRAME_UPPER_LEFT.yellow
      (width - 2).times { print UI_FRAME_HORIZONTAL.yellow }
      print UI_FRAME_UPPER_RIGHT.yellow
      new_line
    end

    def draw_bottom_frame(width)
      print UI_FRAME_LOWER_LEFT.yellow
      (width - 2).times { print UI_FRAME_HORIZONTAL.yellow }
      print UI_FRAME_LOWER_RIGHT.yellow
      new_line
    end

    # Returns actual length of text accounting for UTF-8 and ANSI
    def get_real_size(text)
      text.is_a?(Array) ? text.size : text.uncolorize.size
    end

    # Returns size of longest string in array
    def get_max_size_from_array(array)
      max = 0
      array.each do |s|
        s_size = get_real_size(s)
        max = s_size if s_size >= max
      end
      max + 4
    end
  end
end
