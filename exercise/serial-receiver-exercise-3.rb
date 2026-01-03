require 'serialport'

serial_port = 'COM5'
csv_file = 'sensor_data.csv'

sp = SerialPort.new(serial_port, 115200, 8, 1, 0)

sp.read_timeout = 100

file = nil

begin
  file = File.open(csv_file, 'a')

  loop do
    # バッファクリア: 溜まっているデータをすべて読み捨て
    begin
      sp.read_nonblock(4096)
    rescue IO::WaitReadable
      # バッファが空（正常）
    end

    # 最新データを取得
    line = sp.gets
    sensor = line ? line.to_i : 'none'
    if line
      timestamp = Time.now.strftime('%Y-%m-%d %H:%M:%S')

      file.puts "#{timestamp},#{sensor}"
      file.flush

      puts "#{timestamp},#{sensor}"
    end
    sleep 1
  end
rescue Interrupt
  puts "\n終了します"
ensure
  file.close if file
  sp.close
end