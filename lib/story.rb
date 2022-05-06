#!/usr/bin/env ruby
#
# Written by Webster Avosa
#

module MISSIONGAME
  STORY_INTRO = [
    "This is a game based on the movie series," + "The Originals".light_green +
      ", that has it's setting in New Orleans, Louisiana, United States.",
    "Your mission is to meet " + "Davina Clare".light_white +
      " a very powerful witch of New Orleans,  and free her.",
    "She is currently hostaged by the vampirers under the reign of Klaus Mikaelson.",
    "She will provide you answers of all the questions you've always wanted to know.",
    "",
    "To get stated you will find a " + "map".light_white +
      " in the Mystic Falls of Virginia.",
    "Understanding the map will be key to reaching the destination"
  ]

  STORY_AREA_TREE = [
    "Take a selfie of you before encountering a bloody scene lol."
  ]

  STORY_AREA_WATER = ["You just got close to Mississippi River."]

  STORY_AREA_MOUNTAIN = [
    "A cool place to get yourself a beer before continuing with your mission."
  ]

  STORY_AREA_VILLAINE = ["You encountered a hungry vampire!"]

  STORY_PLAYER_DEAD = [
    "You have been fed on.",
    "",
    "You failed to reach the witch. Please try again."
  ]

  STORY_END = [
    "You've reached Davina Clare, the powerful witch!".light_white,
    "",
    "She stares at you and utters",
    "",
    "I can't imagine the time has finally come".light_yellow,
    "This is going to be the end of dominance by vampires becuase this is your kingdom"
      .light_yellow,
    "you are special and powerful.".light_yellow,
    "",
    "THANK YOU FOR PLAYING!".light_red,
    ""
  ]

  class Story
    def intro
      STORY_INTRO
    end

    def ending
      STORY_END
    end

    def area_tree
      STORY_AREA_TREE
    end

    def area_water
      STORY_AREA_WATER
    end

    def area_mountain
      STORY_AREA_MOUNTAIN
    end

    def area_enemy
      STORY_AREA_VILLAINE
    end

    def player_dead
      STORY_PLAYER_DEAD
    end
  end
end
