require "gosu"
require_relative "z_order"
require "./planet"

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    txt = open("simulations/dance10.txt")
    body = 1
    @bodys = []
    txt.each_line do |line|
      if body == 1
        @nbodys = line.to_i
      end
      if body > 2
        if body < @nbodys + 3
          planet = Planet.new(line.split(" ")[0].to_f,line.split(" ")[1].to_f,line.split(" ")[2].to_f,line.split(" ")[3].to_f,line.split(" ")[4].to_f,Gosu::Image.new("images/#{line.split(" ")[5]}"), @universesize)
          @bodys.push(planet)
        end
      elsif body == 2
        @universesize = line.to_f
      end
      body += 1
    end
    # @sun = Planet.new(0.000e00, 0.000e00, 0.000e00, 0.000e00, 1.989e30, Gosu::Image.new("images/sun.png"))
    # @mercury = Planet.new(5.790e10, 0.000e00, 0.000e00, 4.790e04, 3.302e23, Gosu::Image.new("images/mercury.png"))
    # @venus = Planet.new(1.082e11, 0.000e00, 0.000e00, 3.500e04, 4.869e24, Gosu::Image.new("images/venus.png"))
    # @earth = Planet.new(1.496e11, 0.000e00, 0.000e00, 2.980e04, 5.974e24, Gosu::Image.new("images/earth.png"))
    # @mars = Planet.new(2.279e11, 0.000e00, 0.000e00, 2.410e04, 6.419e23, Gosu::Image.new("images/mars.png"))
    @font = Gosu::Font.new(20)
  end

  def update
    @bodys.each do |body|
      @bodys.each do |b|
        if b != body
          body.force_x(b.x, b.y, b.mass)
          body.force_y(b.x, b.y, b.mass)
        end
      end
      body.accx
      body.accy
      body.f0
    end
    # @mercury.force_x(@sun.x, @sun.y, @sun.mass)
    # @mercury.force_y(@sun.x, @sun.y, @sun.mass)
    # @mercury.accx
    # @mercury.accy
    # @venus.force_x(@sun.x, @sun.y, @sun.mass)
    # @venus.force_y(@sun.x, @sun.y, @sun.mass)
    # @venus.accx
    # @venus.accy
    # @earth.force_x(@sun.x, @sun.y, @sun.mass)
    # @earth.force_y(@sun.x, @sun.y, @sun.mass)
    # @earth.accx
    # @earth.accy
    # @mars.force_x(@sun.x, @sun.y, @sun.mass)
    # @mars.force_y(@sun.x, @sun.y, @sun.mass)
    # @mars.accx
    # @mars.accy
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodys.each do |body|
      body.draw
    end
    # @sun.draw
    # @mercury.draw
    # @venus.draw
    # @earth.draw
    # @mars.draw
    #@font.draw("Forcex: #{@mercury.forcex}", 300, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

end

window = NbodySimulation.new
window.show
