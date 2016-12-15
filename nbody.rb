require "gosu"
require_relative "z_order"
require "./planet"

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    doc = gets.chomp
    txt = open("simulations/#{doc}.txt")
    body = 1
    @bodys = []
    txt.each_line do |line|
      if body == 1
        @nbodys = line.to_i
      end
      if body > 2
        if body < @nbodys + 3 && line != "\n"
          planet = Planet.new(line.split(" ")[0].to_f,line.split(" ")[1].to_f,line.split(" ")[2].to_f,line.split(" ")[3].to_f,line.split(" ")[4].to_f,Gosu::Image.new("images/#{line.split(" ")[5]}"), @universesize)
          @bodys.push(planet)
        end
      elsif body == 2
        @universesize = line.to_f
      end
      body += 1
    end
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
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @bodys.each do |body|
      body.draw
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

end

window = NbodySimulation.new
window.show
