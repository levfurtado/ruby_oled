require 'bundler/setup'
require 'SSD1306'

#holds all values related to vape
class Vape
  #all these values will be displayed on the homescreen
  attr_accessor :id, :voltage, :temperature, :wattage, :heat_mode, :time, :bat_level, :ohms, :substate
end

class Render
  attr_accessor :id, :voltage, :temperature, :wattage, :heat_mode, :time, :bat_level, :ohms, :state, :substate
end

class Homescreen
  attr_accessor :voltage, :temperature, :wattage, :heat_mode, :time, :bat_level, :ohms

  def init
    $disp.clear!
  end

  def push
    $disp.display!
  end

  def substate=(ss)
    @substate = ss
    if @substate == "V"
      $disp.cursor.x_pos = 60
      $disp.cursor.y_pos = 12
    elsif @substate == "J"
      $disp.cursor.x_pos = 60
      $disp.cursor.y_pos = 12
    elsif @substate == "W"
      $disp.cursor.x_pos = 60
      $disp.cursor.y_pos = 12
    end
    $disp.print "#{@substate}"
  end
  def substate
    @substate
  end

  def heat_mode_show=(v)
    @heat_mode = v
    $disp.print "#{@heat_mode}"
  end
  def heat_mode_show
    @heat_mode
  end

  def time_show=(v)
    @time = v
    $disp.print "#{@time}"
  end
  def time_show
    @time
  end


  def profile_show=(p)
    @profile = p
    $disp.print "#{@profile}"
  end
  def profile_show
    @profile
  end

  def am=(t)
    @time = t
    am_or_pm = @time / 1200
    if am_or_pm >= 1
      @time = "PM"
    else
      @time = "AM"
    end
  end
  def am
    @time
  end

end

class Screen_Element
  attr_accessor :content, :x, :y, :font_size
end
#draws bitmaps from hex or dec arrays
def draw_bitmap(bmp)
  $disp.cursor.x_pos = bmp.x
  $disp.cursor.y_pos = bmp.y
  i = 0
  for strip in bmp.content
    $disp.buffer[$disp.cursor.buffer_index + i] = strip
    i = i + 1
  end
end

omega = Screen_Element.new
omega.content = [ 0x9C, 0xBE, 0xC3, 0x01, 0x01, 0xC3, 0xBE, 0x9C ]
omega.x = 120
omega.y = 25

full_batt = Screen_Element.new
full_batt.content = [ 0xFF, 0x81, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0x81, 0xFF, 0x3C ]
full_batt.x = 112
full_batt.y = 0

high_batt = Screen_Element.new
high_batt.content = [ 0xFF, 0x81, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0x81, 0x81, 0x81, 0x81, 0xFF, 0x3C ]
high_batt.x = 112
high_batt.y = 0

low_batt = Screen_Element.new
low_batt.content = [ 0xFF, 0x81, 0xBD, 0xBD, 0xBD, 0xBD, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0xFF, 0x3C ]
low_batt.x = 112
low_batt.y = 0

empty_batt = Screen_Element.new
empty_batt.content = [ 0xFF, 0x81, 0xBD, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0xFF, 0x3C ]
empty_batt.x = 112
empty_batt.y = 0

constant_V = Screen_Element.new
constant_V.x = 121
constant_V.y = 16
constant_V.font_size = 1
constant_V.content = "V"

constant_colon = Screen_Element.new
constant_colon.x = 55
constant_colon.y = 0
constant_colon.font_size = 1
constant_colon.content = ":"

constant_percent = Screen_Element.new
constant_percent.x = 104
constant_percent.y = 0
constant_percent.font_size = 1
constant_percent.content = "%"

substate = Screen_Element.new
substate.x = 60
substate.y = 12
substate.font_size = 2
substate.content = profile.substate

heat_mode = Screen_Element.new
heat_mode.x = 9
heat_mode.y = 0
heat_mode.font_size = 1
heat_mode.content = profile.heat_mode

time_value = Screen_Element.new
time_value.x = 73
time_value.y = 0
time_value.font_size = 1
time_value.content = profile.time

profile = Screen_Element.new
profile.x = 0
profile.y = 0
profile.font_size = 1
profile.content = profile.id

$disp = SSD1306::Display.new(protocol: :i2c, path: '/dev/i2c-1', address: 0x3C, width: 128, height: 32)

profile = Vape.new
render = Render.new
home = Homescreen.new
home.init

profile.id = 1
profile.substate = "V"
profile.time = 120
profile.voltage = "12.6"
profile.heat_mode = "L"

render.id = profile.id
render.time = profile.time
render.substate = profile.substate
render.heat_mode = profile.heat_mode

home.profile_show = render.id
home.am = render.time
home.time_show = home.am
home.substate = render.substate
home.heat_mode_show = render.heat_mode
draw_bitmap(omega)
draw_bitmap(high_batt)

home.push

binding.pry
