require 'bundler/setup'
require 'SSD1306'
disp = SSD1306::Display.new(protocol: :i2c, path: '/dev/i2c-1', address: 0x3C, width: 128, height: 32)

disp.clear!
disp.font_size 1
disp.println "slut"
disp.font_size 2
disp.println "slut"
disp.font_size 1
disp.println "slut"
disp.display!
