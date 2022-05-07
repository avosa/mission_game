Gem::Specification.new do |s|
  s.name = "mission_game"
  s.version = "1.1.4"
  s.summary =
    "This is an open-source text-based adventure game written in Ruby."
  s.authors = ["Webster Avosa"]
  s.email = "websterb17@gmail.com"
  s.files = %w[
    mission_game.rb
    lib/main.rb
    lib/player.rb
    lib/neworleans.rb
    lib/enemy.rb
    lib/ui.rb
    lib/story.rb
  ]
  s.add_runtime_dependency "colorize", "~> 0"
  s.add_runtime_dependency "pry", "~> 0"
  s.executables << "mission_game"
  s.homepage = "https://github.com/avosa/mission_game"
  s.license = "MIT"
end
