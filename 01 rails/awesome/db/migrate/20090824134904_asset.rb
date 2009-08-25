class Asset < ActiveRecord::Migration
  def self.up
    create_table :assets, :force => true do |t|
      t.references :photo
      t.string :public_filename
      t.string :style, :default => 'original'
      t.string :original_filename
      t.string :content_type
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
