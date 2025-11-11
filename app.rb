# ADC（アナログ-デジタル変換）ライブラリを読み込み
require 'adc'

# GPIO27ピンのADCセンサーを初期化
sensor = ADC.new(27)

# 無限ループでセンサー値を読み取り続ける
loop do
  # センサーの生データを読み取ってシリアルポート経由で送信
  puts "#{sensor.read_raw} \r\n"

  # 0.01秒（10ミリ秒）待機してCPU使用率を下げる
  sleep 0.01
end