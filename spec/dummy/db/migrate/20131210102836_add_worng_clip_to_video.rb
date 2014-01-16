class AddWorngClipToVideo < ActiveRecord::Migration
	def self.up
    add_attachment :videos, :wrongClip
  end

  def self.down
    remove_attachment :videos, :wrongClip
  end
end
