require "gosu"

class Planet
  def initialize(x, y, velocityx, velocityy, mass, image, universesize)
    @x = x
    @y = y
    @velocityx = velocityx
    @velocityy = velocityy
    @mass = mass
    @image = image
    @forcex = 0
    @forcey = 0
    @G = 6.674e-11
    @universesize = universesize
  end

  attr_reader :x, :y, :velocityx, :velocityy, :mass, :image, :forcex, :forcey

  def draw
    @image.draw((@x/@universesize)*320 + (640/2) - @image.width/2, (@y/@universesize)*320 + (640/2) - @image.height/2, 1)
  end

  def force_x(px, py, mass)
    force = (@G*mass*@mass)/((@x-px)*(@x-px)+(@y-py)*(@y-py))
    @forcex -= force*((@x-px)/Math.sqrt((@x-px)*(@x-px)+(@y-py)*(@y-py)))
  end

  def force_y(px, py, mass)
    force = (@G*mass*@mass)/((@x-px)*(@x-px)+(@y-py)*(@y-py))
    @forcey -= force*((@y-py)/Math.sqrt((@x-px)*(@x-px)+(@y-py)*(@y-py)))
  end

  def accx
    acc = @forcex/@mass
    @velocityx += acc*25000
    @x += @velocityx*25000
  end

  def accy
    acc = @forcey/@mass
    @velocityy += acc*25000
    @y += @velocityy*25000
  end

  def f0
    @forcex = 0
    @forcey = 0
  end
end
