$gtk.reset

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
    @game_over ||= false
    @player = Player.new
    @enemy = Enemy.new
  end

  class Enemy
    def initialize
      @bounds = ENEMY_BOUNDS
      @width = ENEMY_WIDTH
      @height = ENEMY_HEIGHT
      @x_position = SCREEN_WIDTH / 2
      @y_position ||= SCREEN_HEIGHT 
      @color = [255, 0, 0]
    end
  end

  class Player
   def initialize
    @bounds = PLAYER_BOUNDS
    @width = PLAYER_WIDTH
    @height = PLAYER_HEIGHT
    @x_position ||= SCREEN_HEIGHT / 2
    @y_position = 50
    @color = [0, 255,0]
   end

    def draw_player
      return {x: @x_position, y: @y_position, w: @width, h: @height, r: @color[0], g: @color[1], b: @color[2]}
    end
  end

  
  
  def game_state
   if @game_over == true
    return game_over 
   end
   return gameplay

  end

  def gameplay
    render_gameplay
    
  end

  def game_over
    render_game_over
  end
  
  
  def render_gameplay

    @args.outputs.solids << @player.draw_player

  end

  def render_game_over
  end

  def reset_game
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


