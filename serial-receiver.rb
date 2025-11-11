# SerialPortライブラリを読み込み
require 'serialport'

# シリアルポート名を変数に設定（環境に応じて変更）
serial_port = 'COM5'
# シリアルポートを開く（ボーレート115200, データビット8, ストップビット1, パリティなし）
sp = SerialPort.new(serial_port, 115200, 8, 1, 0)
# シリアルポート情報を表示
puts sp

# 読み取りタイムアウトを100ミリ秒に設定
sp.read_timeout = 100

# 例外処理ブロック開始
begin
  # 無限ループでデータを受信し続ける
  loop do
    # シリアルポートから1行読み取り
    line = sp.gets
    # 読み取ったデータを表示（データがなければ'none'を表示）
    puts line ? line : 'none'
  end
rescue Interrupt
  # Ctrl+Cなどの割り込みをキャッチして終了メッセージを表示
  puts "\n終了します"
ensure
  # プログラム終了時に必ずシリアルポートを閉じる
  sp.close
end