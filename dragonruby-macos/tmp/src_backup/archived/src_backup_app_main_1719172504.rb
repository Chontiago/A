SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720
PLAYER_WIDTH = 100
PLAYER_HEIGHT = 50
ENEMY_WIDTH = 50
ENEMY_HEIGHT = 50
PLAYER_BOUNDS = SCREEN_WIDTH + PLAYER_WIDTH
ENEMY_BOUNDS = 0 - ENEMY_HEIGHT
RED = [255, 0 ,0]
GREEN = [0, 0, 255]


class Game

  def initialize(args)
    @args = args

  end

  class Enemy
    def initialize
      @bounds = ENEMY_BOUNDS
      @width = ENEMY_WIDTH
      @height = ENEMY_HEIGHT
      @x_position = random((0 + 50)..(SCREEN_HEIGHT) / 50)
      @y_position ||= SCREEN_HEIGHT - ENEMY_HEIGHT



    end

    def draw_enemy(@x_position)
      
    end
    
    def speed
    end

    def enemy_position

    def position()
  end

  class Player
    @bounds = PLAYER_BOUNDS
    @width = PLAYER_WIDTH
    @height = PLAYER_HEIGHT
    @x_position ||= SCREEN_HEIGHT / 2
    @y_position = 0
  end

  def draw_player
    
  end
  
  def game_state
    @args.outputs.solids << [SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, PLAYER_WIDTH, PLAYER_HEIGHT ] #x, y, w, h    
  end

  def gameplay
  end

  def game_over
  end

  def collision(box1, box2) # box1 enemy, box2 player
    box1[:y] <= box2[:y] + box2[:h] &&
    box1[:x] + box1[:w] >= box2[:x] &&
    box1[:x] <= box2[:x] + box2[:w]
  end
    
  def tick
    game_state
  end

end

def tick (args)
  args.state.game ||= Game.new(args)
  args.state.game.tick  
end


