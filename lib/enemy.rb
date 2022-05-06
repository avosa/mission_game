#!/usr/bin/env ruby
#
# Written by Webster Avosa
#

module MISSIONGAME
  ENEMY_CATALOG = [
    [name: "Lucien Castle", lives: 3, bonus: 0, str: 3, points: 1],
    [name: "Klaus Mikaelson", lives: 8, bonus: 8, str: 4, points: 10],
    [name: "Damon Salvatore", lives: 5, bonus: 0, str: 4, points: 7],
    [name: "Mikael", lives: 3, bonus: 2, str: 4, points: 6],
    [name: "Taylor Lockwood", lives: 4, bonus: 0, str: 4, points: 2],
    [name: "Marcel Gerard", lives: 7, bonus: 3, str: 5, points: 5],
    [name: "Dahlia", lives: 2, bonus: 6, str: 1, points: 2],
    [name: "The Hollow", lives: 5, bonus: 0, str: 4, points: 3],
    [name: "Celeste Dubois", lives: 3, bonus: 10, str: 2, points: 5]
  ]

  PLAYER_DEAD = "PLAYER_DEAD"

  class Enemy
    attr_accessor :name
    attr_accessor :lives
    attr_accessor :bonus
    attr_accessor :str
    attr_accessor :int
    attr_accessor :points

    def initialize(args = nil)
      # Pick a random enemy
      selected_enemy = ENEMY_CATALOG.sample[0]
      @name = selected_enemy[:name]
      @lives = selected_enemy[:lives] + rand(0..3)
      @bonus = selected_enemy[:bonus] + rand(0..3)
      @str = selected_enemy[:str]
      @points = selected_enemy[:points]
      @int = rand(2..6)
    end

    # Enemy attacks player
    def attack(args)
      enemy = self
      player = args[:player]

      # Does the enemy even hit the player?
      str_diff = (enemy.str - player.str) * 2
      hit_chance = rand(1...100) + str_diff

      if hit_chance > 30
        # Determine value of the attack
        attack_value = rand(1...player.str)
        print enemy.name.light_red + " hits you for " +
          attack_value.to_s.light_yellow + " damage(s)!\n"
        if attack_value > player.lives
          return PLAYER_DEAD
        else
          return attack_value
        end
      else
        print enemy.name.light_red + " sees you as an easy prey!\n"
      end
      true
    end
  end
end
