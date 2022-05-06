#!/usr/bin/env ruby
#
# Written by Webster Avosa

GAME_VERSION = "1.00"

begin
  require "colorize"
  require "pry"
rescue LoadError
  puts
  puts "This game requires the 'colorize' and 'pry' gem to run."
  puts
  puts "Installation Instructions"
  puts "-------------------------"
  puts
  puts "Debian/Ubuntu Linux:"
  puts "  sudo apt install ruby-colorize && sudo apt install pry"
  puts
  puts "Other Linux Distros:"
  puts "  gem install colorize && gem install pry"
  puts
  puts "Windows:"
  puts "  gem install colorize && gem install pry"
  puts
  puts "macOS:"
  puts "  gem install colorize && gem install pry"
  puts
  puts
  exit
end

# Require libraries
load "lib/ui.rb"
load "lib/neworleans.rb"
load "lib/player.rb"
load "lib/story.rb"
load "lib/enemy.rb"

# Start
load "lib/main.rb"
