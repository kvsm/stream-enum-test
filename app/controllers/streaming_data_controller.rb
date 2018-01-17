class StreamingDataController < ApplicationController
  def index
    headers['X-Accel-Buffering'] = 'no'
    headers['Cache-Control'] = 'no-cache'
    headers.delete("Content-Length")
    headers['Content-Type'] = 'text/csv'
    headers['Content-Disposition'] =
      %(attachment; filename="file.csv")
    headers['Last-Modified'] = Time.zone.now.ctime.to_s
    self.response_body = Enumerator.new { |y| slowly_generate_data(y) }
  end

  private

  def slowly_generate_data(yielder)
    1000.times do |n|
      sleep 0.03
      yielder << "\n#{SecureRandom.hex(1000)}"
    end
  end
end
