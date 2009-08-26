class Asset < ActiveRecord::Base
  
  # ===============
  # = Validations =
  # ===============
  validates_presence_of :style, :original_filename, :content_type
  
  # ================
  # = Associations =
  # ================
  belongs_to :photo
  
  # ==========
  # = Scopes =
  # ==========
  named_scope :preview, :conditions => { :style => 'preview' }

  # ======================
  # = Virtual Attributes =
  # ======================
  attr_accessor :content, :content_path
  
  # =============
  # = Callbacks =
  # =============
  after_create :publish_content
  after_commit_on_create :notify_subscribers
  
  def content=(content)
    self.original_filename = content.original_filename
    self.content_type      = content.content_type
    @content_path = content.path
    @content = content
  end
  
  def path
    "#{Rails.root}/public#{public_filename}"
  end
  
  private
  
    def publish_content
      update_attribute :public_filename, "/photos/#{photo.id}/#{original_filename}"
      FileUtils.mkdir_p(File.dirname(path))
      FileUtils.cp @content_path, path
    end
    
    def notify_subscribers
      return unless original?
      
      bunny = Bunny.new
      bunny.start
      queue = bunny.queue('images')
      queue.publish(id)
    end
    
    def original?
      style.to_sym == :original
    end
  
end