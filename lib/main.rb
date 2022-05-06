#!/usr/bin/env ruby
#
# Written by Webster AVosa

MISSIONGAME_VERSION = "1.00"

# Create a new UI and New Orleans
ui = MISSIONGAME::UI.new
neworleans = MISSIONGAME::NewOrleans.new

# Clear the screen and print welcome message
ui.clear
ui.welcome

# Ask name
name = ui.ask("What is your name?", /\w/)

# Create a new player
player = MISSIONGAME::Player.new({name: name, neworleans: neworleans})

# Show intro story
ui.new_line
story = MISSIONGAME::Story.new
ui.draw_frame({text: story.intro})

# MAIN INPUT LOOP
running = 1
while running
  ui.new_line

  # Get command from user
  cmd = ui.get_cmd
  case cmd
  when "~"
    binding.pry
  when "map", "m"
    map = neworleans.get_map({player: player})
    ui.draw_frame({text: map})
  when "version", "ver"
    ui.display_version
  when "clear", "cls"
    ui.clear
  when "name", "whoami"
    ui.display_name({player: player})
  when "location", "loc", "where", "whereami"
    ui.show_location({player: player})
  when "look", "what", "around"
    neworleans.check_area({player: player, ui: ui, story: story})
  when "forward", "f"
    if player.in_combat
      ui.cannot_travel_combat
    elsif !player.move(
      {direction: :up, neworleans: neworleans, ui: ui, story: story}
    )
      player.in_combat = 1
    end
  when "backward", "b"
    if player.in_combat
      ui.cannot_travel_combat
    elsif !player.move(
      {direction: :down, neworleans: neworleans, ui: ui, story: story}
    )
      player.in_combat = 1
    end
  when "left", "l"
    if player.in_combat
      ui.cannot_travel_combat
    elsif !player.move(
      {direction: :left, neworleans: neworleans, ui: ui, story: story}
    )
      player.in_combat = 1
    end
  when "right", "r"
    if player.in_combat
      ui.cannot_travel_combat
    elsif !player.move(
      {direction: :right, neworleans: neworleans, ui: ui, story: story}
    )
      player.in_combat = 1
    end
  when "attack", "a"
    if player.in_combat
      retval = player.attack({enemy: player.current_enemy, ui: ui})
      if retval == MISSIONGAME::ENEMY_KILLED
        player.points += player.current_enemy.points

        # Remove enemy from map
        neworleans.the_map[player.y - 1][player.x - 1] =
          MISSIONGAME::MAP_KEY_GRASS

        # Take player out of combat
        player.current_enemy = nil
        player.in_combat = false
      end
      if retval.is_a? Numeric
        player.current_enemy.lives -= retval
        retval = player.current_enemy.attack({player: player})
        player.lives -= retval if retval.is_a? Numeric
        player.dead = 1 if retval == MISSIONGAME::PLAYER_DEAD
      end
    else
      ui.not_in_combat
    end
  when "player", "me", "info", "status", "i"
    ui.player_info({player: player})
  when "enemy"
    player.in_combat ? ui.enemy_info({player: player}) : ui.not_in_combat
  when "points", "score"
    ui.points({player: player})
  when "suicide"
    player.dead = 1
  when "help", "h", "?"
    ui.help
  when "quit", "q", "exit"
    ui.quit
    running = nil
  else
    ui.not_found
  end

  # Is player in combat but has no enemy? Assign one.
  if player.in_combat && !player.current_enemy
    enemy = MISSIONGAME::Enemy.new
    player.current_enemy = enemy
    ui.enemy_greet({enemy: enemy})
  end

  # Player is dead!
  if player.dead == 1
    ui.player_dead({story: story})
    exit
  end

  # If player has reached the Witch
  if player.x == MISSIONGAME::MAP_WIDTH && player.y == 1
    ui.draw_frame({text: story.ending})
    ui.new_line
    running = false
  end
end
