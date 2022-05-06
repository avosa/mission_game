#!/usr/bin/env ruby
#
# Written by Webster Avosa

module MISSIONGAME
  ENEMY_KILLED = "KILLED"

  HIT_CHANCE_MODIFIER = 5
  ATTACK_VALUE_MODIFIER = 1

  class Player
    attr_accessor :name
    attr_accessor :lives
    attr_accessor :bonus
    attr_accessor :x
    attr_accessor :y
    attr_accessor :level
    attr_accessor :str
    attr_accessor :int
    attr_accessor :in_combat
    attr_accessor :current_enemy
    attr_accessor :points
    attr_accessor :dead

    def initialize(args)
      name = args[:name]
      neworleans = args[:neworleans]
      @name = name
      @level = 1
      @lives = 100
      @bonus = 100
      @str = 5
      @int = 5
      @x = 1
      @y = neworleans.get_height
      @in_combat = false
      @current_enemy = nil
      @points = 0
      @dead = 0
      "Welcome %{name}! Let's play!"
    end

    # Player attacks enemy
    def attack(args)
      player = self
      enemy = args[:enemy]
      ui = args[:ui]

      # Does the player even hit the enemy?
      # We could use a hit chance stat here, but since we don't have one,
      # we'll just base it off the player/enemy stength discrepency.
      ui.enemy_info({player: player})
      ui.player_info({player: player})
      str_diff = (player.str - enemy.str) * 2
      hit_chance = rand(1...100) + str_diff + HIT_CHANCE_MODIFIER

      if hit_chance > 50
        # Determine value of the attack
        attack_value = rand(1...player.str) + ATTACK_VALUE_MODIFIER
        if attack_value > enemy.lives
          print "You fought for your life and " + "hit".light_yellow + " " +
            enemy.name.light_red + " for " +
            attack_value.to_s.light_white + " damages, killing him!\n"
          print "You gain " + enemy.points.to_s.light_white + " points.\n"
          ENEMY_KILLED
        else
          print "You fought for your life and " + "hit".light_yellow + " " +
            enemy.name.light_red + " for " +
            attack_value.to_s.light_white + " damages, killing him!\n"
          attack_value
        end
      else
        print "You fought for your life and " + "missed".light_red + " " +
          enemy.name + "!\n"
        0
      end
      true
    end

    def move(args)
      direction = args[:direction]
      neworleans = args[:neworleans]
      ui = args[:ui]
      story = args[:story]
      case direction
      when :up
        if @y > 1
          @y -= 1
        else
          ui.out_of_bounds
          return false
        end
      when :down
        if @y < neworleans.get_height
          @y += 1
        else
          ui.out_of_bounds
          return false
        end
      when :left
        if @x > 1
          @x -= 1
        else
          ui.out_of_bounds
          return false
        end
      when :right
        if @x < neworleans.get_width
          @x += 1
        else
          ui.out_of_bounds
          return false
        end
      end
      if neworleans.check_area({player: self, ui: ui, story: story})
        true
      else
        false
      end
    end
  end
end
