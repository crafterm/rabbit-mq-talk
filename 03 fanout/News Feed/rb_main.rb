#
#  rb_main.rb
#  Vid
#
#  Created by Marcus Crafter on 18/08/09.
#  Copyright (c) 2009 Red Artisan. All rights reserved.
#

require 'rubygems'
require 'bunny'
Bunny.new
require 'osx/cocoa'

OSX.require_framework 'QTKit'
OSX.require_framework '/Users/crafterm/Downloads/BWToolkit/BWToolkitFramework.framework'

def rb_main_init
  path = OSX::NSBundle.mainBundle.resourcePath.fileSystemRepresentation
  rbfiles = Dir.entries(path).select {|x| /\.rb\z/ =~ x}
  rbfiles -= [ File.basename(__FILE__) ]
  rbfiles.each do |path|
    require( File.basename(path) )
  end
end

if $0 == __FILE__ then
  rb_main_init
  OSX.NSApplicationMain(0, nil)
end
