$gtk.reset

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720
HALF_SCREEN_WIDTH = SCREEN_WIDTH / 2
HALF_SCREEN_HEIGHT = SCREEN_HEIGHT / 2
CUBE_SIZE = 50
PLAYER_WIDTH = CUBE_SIZE * 2
PLAYER_X_POS = HALF_SCREEN_WIDTH - CUBE_SIZE
ENEMY_Y_POS = SCREEN_HEIGHT - CUBE_SIZE

LINE_SKIP = 50
PLAYER_BOUNDS = SCREEN_WIDTH + PLAYER_WIDTH

RED = [255, 0 ,0]
BLUE = [0, 0, 255]
PLAYER_SPEED = 5
NEXT_FALL = 2


class Game
  def initialize(args)
    @args = args
    @game_over ||= false
    #@randomize_x_pos = random(0..SCREEN_WIDTH)
    @player = Cubes.new(PLAYER_X_POS, 0, PLAYER_WIDTH).draw_cube
    #@enemy = Cubes.new(@randomize_x_pos, ENEMY_Y_POS, CUBE_SIZE ).draw_cube
    @move ||= nil
    @score ||= 0
    @fall_speed  ||= 5
  end

  class Cubes
    attr_accessor :x

    def initialize(x, y, width)
      @x = x
      @y = y
      @width = width
      @height = CUBE_SIZE
    end

    def draw_cube
      return {x: @x, y: @y, w: @width , h: @height }
    end
  end

  class Player
    attr_accessor :x_position

    def initialize
    @bounds = PLAYER_BOUNDS
    @width = PLAYER_WIDTH
    @height = PLAYER_HEIGHT
    @x_position ||= (SCREEN_WIDTH / 2) - (PLAYER_WIDTH / 2)
    @y_position = 0
    @rgb = [0, 0 ,255]
   end

    def draw_player
      return {x: @x_position, y: @y_position, w: @width, h: @height, r: @rgb[0], g: @rgb[1], b: @rgb[2]}
    end
  end

  class Text
    def initialize(args, y, text)
      @args = args
      @x = HALF_SCREEN_WIDTH
      @y = y
      @text = text
    end

    def draw_text
      @args.outputs.labels << {x: @x, y: @y, anchor_x: 0.5, anchor_y: 0.5, text: @text}
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
   # player_movement
  end

  def game_over
    render_game_over
    reset_game
  end
  
  
  def render_gameplay
    @args.outputs.solids << @player.draw_player
    @args.outputs.solids << @enemy.draw_enemy
  end

  def player_movement
    move_left = lambda {@player.x_position -= PLAYER_SPEED }
    move_right =lambda{@player.x_position += PLAYER_SPEED}

    key_pressed(:left, move_left)
    key_pressed(:right, move_right)
  end

  def render_game_over
    Text.new(@args, HALF_SCREEN_HEIGHT, "GAME OVER").draw_text 
    Text.new(@args, HALF_SCREEN_HEIGHT - (LINE_SKIP * 2), "PRESS ENTER TO RESTART").draw_text

  end

  def reset_game
    key_pressed(:enter, $gtk.method(:reset))
  end

  def key_pressed(key, action)
    if @args.inputs.keyboard.key_held.send(key) 
      action.call
    end
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
