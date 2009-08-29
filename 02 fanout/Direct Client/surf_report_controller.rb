#
#  surf_report_controller.rb
#  Direct Client
#
#  Created by Marcus Crafter on 16/08/09.
#  Copyright (c) 2009 Red Artisan. All rights reserved.
#

require 'osx/cocoa'

class SurfReportController < OSX::NSObject

#  BEACHES = %w( Bells Waikiki Pipeline Postmans )
  
  BEACHES = [
    { :name => 'Bells', :temperature => 15, :high => 6.04, :low => 4.55, :weather => 'Average' },
    { :name => 'Waikiki', :temperature => 25, :high => 5.35, :low => 5.23, :weather => 'Good' },
    { :name => 'Pipeline', :temperature => 24, :high => 6.37, :low => 3.33, :weather => 'Excellent' },
    { :name => 'Postmans', :temperature => 10, :high => 7.45, :low => 5.23, :weather => 'Good' },
  ]

  kvc_accessor :beaches
  
  def init
    if super_init
      @beaches = OSX::NSMutableArray.array
    end
    return self
  end
  
  def awakeFromNib
    proxy = self.mutableArrayValueForKey('beaches')

    BEACHES.each do |data|
      beach = Beach.alloc.init
      beach.name = data[:name]
      beach.temperature = data[:temperature]
      beach.high = data[:high]; beach.low = data[:low]
      beach.weather = data[:weather]
      proxy.addObject(beach)
    end
  end

end
