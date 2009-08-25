#
#  beach.rb
#  Direct Client
#
#  Created by Marcus Crafter on 16/08/09.
#  Copyright (c) 2009 Red Artisan. All rights reserved.
#

require 'osx/cocoa'

class Beach < OSX::NSObject

  kvc_accessor :name, :swell, :temperature, :high, :low, :weather

  def init
    if super_init
      @swell = 1.0
      @queue = DirectClient.new('surfreport')
    end
    return self
  end
  
  def beach_photo_path
    bundle = OSX::NSBundle.mainBundle
    bundle.pathForResource_ofType(name.downcase, 'jpg')
  end
  
  def swell=(size)
    notify_queue(size)
    @swell = size
  end
  
  private
  
    def notify_queue(size)      
      #@queue.publish("swell for #{name} changing to #{size}")
      @queue.publish(Marshal.dump(:beach => name, :size => size.to_f))
    end

end

# Waikiki  http://www.flickr.com/photos/79546474@N00/3217165482/
# Pipeline http://www.flickr.com/photos/blacknell/3448927323/
# Bells    http://www.flickr.com/photos/tonyprysten/322086972/
# Postmans http://www.flickr.com/photos/tk_five_0/1310759230/
