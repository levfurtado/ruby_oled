require 'bundler/setup'
require 'SSD1306'
disp = SSD1306::Display.new(protocol: :i2c, path: '/dev/i2c-1', address: 0x3C, width: 128, height: 32)

disp.println "This is my IP Address:"
disp.println "" # The same as disp.print "\n"
disp.font_size 2
disp.println("lol")
disp.display!
