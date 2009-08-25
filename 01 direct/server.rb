require 'rubygems'
require 'mq'

AMQP.start(:host => 'localhost') do

  def log *args
    p [ Time.now, *args ]
  end
  
  amq = MQ.new
  
  amq.queue('surfreport').subscribe do |msg|
    content = Marshal.load(msg)
    log :received, "Updated surf report for #{content[:beach]}, swell #{content[:size]} feet"
  end
  
end
