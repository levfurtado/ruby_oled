# profile1.bat_level.content = [ 0xFF, 0x81, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0x81, 0xFF, 0x3C ], [ 0xFF, 0x81, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0x81, 0x81, 0x81, 0x81, 0xFF, 0x3C ], [ 0xFF, 0x81, 0xBD, 0xBD, 0xBD, 0xBD, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0xFF, 0x3C ], [ 0xFF, 0x81, 0xBD, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0x81, 0xFF, 0x3C ]

require 'bundler/setup'
require 'SSD1306'

#holds all values related to vape
class Vape
  #all these values will be displayed on the homescreen
  attr_accessor :id, :voltage, :temperature, :wattage, :heat_mode, :time, :bat_level, :ohms, :substate, :omega, :constant_V, :constant_colon, :constant_percent, :battery_percent, :current_voltage, :current_ohms, :current_set_voltage, :current_hour, :current_minute
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

  def print_scr_element(se)
    $disp.cursor.x_pos = se.x
    $disp.cursor.y_pos = se.y
    if se.font_size
      $disp.cursor.size = se.font_size
    end
    $disp.print "#{se.content}"
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

profile1 = Vape.new
render = Render.new
home = Homescreen.new

$disp = SSD1306::Display.new(protocol: :i2c, path: '/dev/i2c-1', address: 0x3C, width: 128, height: 32)

profile1.id = Screen_Element.new
profile1.id.x = 0
profile1.id.y = 0
profile1.id.font_size = 1
profile1.id.content = 2

profile1.omega = Screen_Element.new
profile1.omega.content = [ 0x9C, 0xBE, 0xC3, 0x01, 0x01, 0xC3, 0xBE, 0x9C ]
profile1.omega.x = 120
profile1.omega.y = 25

profile1.bat_level = Screen_Element.new
profile1.bat_level.content = [ 0xFF, 0x81, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0x81, 0xFF, 0x3C ]
profile1.bat_level.x = 112
profile1.bat_level.y = 0

profile1.constant_V = Screen_Element.new
profile1.constant_V.x = 121
profile1.constant_V.y = 16
profile1.constant_V.font_size = 1
profile1.constant_V.content = "V"

profile1.constant_colon = Screen_Element.new
profile1.constant_colon.x = 55
profile1.constant_colon.y = 0
profile1.constant_colon.font_size = 1
profile1.constant_colon.content = ":"

profile1.constant_percent = Screen_Element.new
profile1.constant_percent.x = 104
profile1.constant_percent.y = 0
profile1.constant_percent.font_size = 1
profile1.constant_percent.content = "%"

profile1.substate = Screen_Element.new
profile1.substate.x = 60
profile1.substate.y = 16
profile1.substate.font_size = 2
profile1.substate.content = "V"

profile1.heat_mode = Screen_Element.new
profile1.heat_mode.x = 9
profile1.heat_mode.y = 0
profile1.heat_mode.font_size = 1
profile1.heat_mode.content = "L"

profile1.time = Screen_Element.new
profile1.time.x = 73
profile1.time.y = 0
profile1.time.font_size = 1
profile1.time.content = 2220
home.am = profile1.time.content

profile1.battery_percent = Screen_Element.new
profile1.battery_percent.x = 92
profile1.battery_percent.y = 0
profile1.battery_percent.font_size = 1
profile1.battery_percent.content = 73

profile1.current_ohms = Screen_Element.new
profile1.current_ohms.x = 95
profile1.current_ohms.y = 24
profile1.current_ohms.font_size = 1
profile1.current_ohms.content = 0.24

profile1.current_voltage = Screen_Element.new
profile1.current_voltage.x = 95
profile1.current_voltage.y = 16
profile1.current_voltage.font_size = 1
profile1.current_voltage.content = 3.25

profile1.current_set_voltage = Screen_Element.new
profile1.current_set_voltage.x = 0
profile1.current_set_voltage.y = 16
profile1.current_set_voltage.font_size = 2
profile1.current_set_voltage.content = 10.25

profile1.current_hour = Screen_Element.new
profile1.current_hour.x = 43
profile1.current_hour.y = 0
profile1.current_hour.font_size = 1
profile1.current_hour.content = profile1.time.content / 100

profile1.current_minute = Screen_Element.new
profile1.current_minute.x = 61
profile1.current_minute.y = 0
profile1.current_minute.font_size = 1
profile1.current_minute.content = profile1.time.content % 100

profile1.time.content = home.am

# home.init

# profile1.id = 1
# profile1.substate = "V"
# profile1.time = 120
# profile1.voltage = "12.6"
# profile1.heat_mode = "L"
#
# render.id = profile1.id
# render.time = profile1.time
# render.substate = profile1.substate
# render.heat_mode = profile1.heat_mode
#
# home.profile_show = render.id
# home.am = render.time
# home.time_show = home.am
# home.substate = render.substate
# home.heat_mode_show = render.heat_mode
draw_bitmap(profile1.omega)
draw_bitmap(profile1.bat_level)
home.print_scr_element(profile1.id)
home.print_scr_element(profile1.constant_V)
home.print_scr_element(profile1.constant_colon)
home.print_scr_element(profile1.constant_percent)
home.print_scr_element(profile1.time)
home.print_scr_element(profile1.heat_mode)
home.print_scr_element(profile1.substate)
home.print_scr_element(profile1.battery_percent)
home.print_scr_element(profile1.current_ohms)
home.print_scr_element(profile1.current_voltage)
home.print_scr_element(profile1.current_set_voltage)
home.print_scr_element(profile1.current_hour)
home.print_scr_element(profile1.current_minute)

home.push
