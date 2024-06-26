SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720
PLAYER_WIDTH = 100
PLAYER_HEIGHT = 50
ENEMY_WIDTH = 50
ENEMY_HEIGHT = 50

class Game

  def initialize(args)
    @args = args

  end

  class Enemy
  end

  class Player
  end


  
  def game_state
    @args.outputs.solids << [SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, PLAYER_WIDTH, PLAYER_HEIGHT ] #x, y, w, h    
  end
    
  def tick
    game_state
  end

end

def tick (args)
  args.state.game ||= Game.new(args)
  args.state.game.tick  
end


