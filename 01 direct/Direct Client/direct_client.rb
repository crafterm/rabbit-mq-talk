#
#  queue.rb
#  Direct Client
#
#  Created by Marcus Crafter on 17/08/09.
#  Copyright (c) 2009 Red Artisan. All rights reserved.
#

class DirectClient

  def initialize(queue)
    @bunny = Bunny.new
    @bunny.start
    @queue = @bunny.queue(queue)
  end

  def publish(message)
    @queue.publish(message)
  end
  
end
