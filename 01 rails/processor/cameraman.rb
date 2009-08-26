$:.unshift('vendor')

require 'red_artisan/core_image/processor'

class ProcessorBase
  
  def initialize(asset)
    @asset = asset
    @resource = RedArtisan::CoreImage::Processor.new OSX::CIImage.from(asset.path)
  end
  
  def process(&block)
    result, style = block.call @resource
    register result, style
  end
  
  private
  
    def register(result, style)
      returning Asset.new do |asset|
        asset.content_path = result
        asset.original_filename = File.basename(result)
        asset.content_type = 'image/jpeg'
        asset.photo = @asset.photo
        asset.style = style.to_s
        asset.save!
      end
    end
    
end

class Cameraman
  
  def self.preview(asset)
    p = ProcessorBase.new(asset)
    p.process do |image|
      image.thumbnail(50, 50)
      image.render do |result|
        path = "/tmp/#{asset.id}-preview.jpg"
        result.save(path, OSX::NSJPEGFileType)
        [ path, :preview ]
      end
    end
  end
  
  def self.greyscale(asset)
    p = ProcessorBase.new(asset)
    p.process do |image|
      image.greyscale
      image.render do |result|
        path = "/tmp/#{asset.id}-greyscale.jpg"
        result.save(path, OSX::NSJPEGFileType)
        [ path, :greyscale ]
      end
    end
  end

  def self.watermark(asset)
    p = ProcessorBase.new(asset)
    p.process do |image|
      image.watermark('watermark.png', true, 0.05)
      image.render do |result|
        path = "/tmp/#{asset.id}-watermarked.jpg"
        result.save(path, OSX::NSJPEGFileType)
        [ path, :watermark ]
      end
    end
  end

end

