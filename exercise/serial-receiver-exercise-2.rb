require 'serialport'

serial_port = 'COM5'
sp = SerialPort.new(serial_port, 115200, 8, 1, 0)
puts sp

sp.read_timeout = 100

begin
  loop do
    line = sp.gets
    sensor = line ? line.to_i : 'none'
    if sensor != 'none'
      puts "#{sensor} : #{'#' * (sensor / 100)}"
    else
      puts 'センサー値: none'
    end
  end
rescue Interrupt
  puts "\n終了します"
ensure
  sp.close
end