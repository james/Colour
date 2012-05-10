require 'sinatra'
require 'rvg/rvg'

get '/:hex.png' do |hex|
  rvg = Magick::RVG.new(45, 45) do |canvas|
      canvas.background_fill = "##{hex}"
  end
  img = rvg.draw
  img.format = "png"
  content_type :png
  img.to_blob
end