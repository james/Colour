require 'sinatra'
require 'rvg/rvg'

get '/:hex.png' do |hex|
  make_img(hex).to_blob
end

get '/:hex/:text.png' do |hex, text|
  make_img(hex, text).to_blob
end

def make_img(hex, text=nil)
  rvg = Magick::RVG.new(114, 114) do |canvas|
    canvas.background_fill = "##{hex}"
    if text
      canvas.text(57, 65) do |title|
        title.tspan(text).styles(:text_anchor=>'middle', :font_size=>30, :font_family=>'Gill Sans', :fill=>'black', :font_weight => 'bold')
      end
    end
  end
  img = rvg.draw
  img.format = "png"
  content_type :png
  img
end