require 'rqrcode'

class Api::V1::QrCodesController < ApplicationController
  def generate
    text = params[:text]
    return render json: { error: 'Text parameter is required' }, status: :bad_request if text.blank?

    begin
      qr = RQRCode::QRCode.new(text)

      png = qr.as_png(
        bit_depth: 1,
        border_modules: 4,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: 'black',
        file: nil,
        fill: 'white',
        module_px_size: 6,
        resize_exactly_to: false,
        size: 240
      )

      send_data png.to_s, type: 'image/png', disposition: 'inline'
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
