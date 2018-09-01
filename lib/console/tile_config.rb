class TileConfig
  def initialize(standard_symbol, emoji)
    @symbol = standard_symbol
    @emoji  = emoji
    @config = get_config
  end

  def tile_symbol
    @config[:tile_symbol].to_s
  end

  def color
    @config[:color]
  end

  def background
    @config[:background]
  end

  def standard
    @config[:tile_symbol] = @symbol
  end

  def emoji
    @config[:tile_symbol] = @emoji
  end

  private
  def get_config
    return default_x_config if @symbol == :X
    return default_o_config if @symbol == :O
  end

  def default_x_config
    { :tile_symbol => :X,
      :color       => :light_blue,
      :background  => :on_cyan
    }
  end

  def default_o_config
    { :tile_symbol => :O,
      :color       => :green,
      :background  => :on_light_green
    }
  end
end
