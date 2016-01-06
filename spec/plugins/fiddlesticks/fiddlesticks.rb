require 'mygen'

class Fiddlesticks < Mygen::Generator
  def description
    "This is a long description"
  end
  def plugin_commands(gen)
    gen.desc 'Plays the fiddle'
    gen.command :play do |wip|
      wip.action do
        play
      end
    end
  end

  def play
    puts "Fiddledii"
  end
end
