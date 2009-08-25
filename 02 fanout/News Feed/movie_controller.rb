#
#  movie_controller.rb
#  Vid
#
#  Created by Marcus Crafter on 18/08/09.
#  Copyright (c) 2009 Red Artisan. All rights reserved.
#

require 'osx/cocoa'

class MovieController < OSX::NSObject

  ib_action :forward
  ib_action :backward
  ib_action :play_pause
  
  kvc_accessor :movie_view, :movie, :playing, :playing_title
  
  def awakeFromNib
    @movie = @movie_view.movie
    self.playing = false
    self.playing_title = 'Play'
    
    Thread.new do
      bunny = Bunny.new
      bunny.start
      queue = bunny.queue('surfreport')

      loop do
        queue.subscribe do |msg|
          content = Marshal.load(msg)
          seek_to(content[:size])
        end
      end
    end
  end
  
  def play_pause
    self.playing ? @movie.stop : @movie.play
    self.playing = !playing
    self.playing_title = playing ? 'Pause' : 'Play'
  end
  
  def forward
    @movie.setCurrentTime(from_now(10))
  end
  
  def seek_to(time_in_seconds)
    @movie.setCurrentTime(OSX::QTMakeTimeWithTimeInterval(time_in_seconds))
  end
  
  def backward
    @movie.setCurrentTime(from_now(-10))
  end
  
  private
  
    def from_now(interval_in_seconds)
      current_time = @movie.currentTime
      interval = OSX::QTMakeTimeWithTimeInterval(interval_in_seconds)
      OSX::QTTimeIncrement(current_time, interval)
    end
  
end
