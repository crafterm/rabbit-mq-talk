$:.unshift('../photos')

require 'rubygems'
require 'mq'
require 'config/environment'
require 'cameraman'

AMQP.start(:host => 'localhost') do

  def log *args
    p [ Time.now, *args ]
  end
  
  amq = MQ.new
  
  amq.queue('images').subscribe do |id|
    log :received, "new asset has been created, id: #{id}"
    asset = Asset.find id
    Cameraman.preview(asset)
    Cameraman.greyscale(asset)
    Cameraman.watermark(asset)
    Cameraman.edges(asset)
  end
  
end
