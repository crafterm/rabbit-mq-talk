$:.unshift('../photos')

require 'rubygems'
require 'config/environment'

photos = Dir['/Users/crafterm/Pictures/Lightroom Exports/*.jpg']

photos.each do |path|
  photo = Photo.new :name => 'photo', :description => 'imported photo'
  asset = photo.assets.build
  asset.content_path = path
  asset.original_filename = File.basename(path)
  asset.content_type = 'image/jpeg'
  asset.style = 'original'
  photo.save!
end