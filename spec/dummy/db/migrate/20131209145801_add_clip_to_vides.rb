class AddClipToVides < ActiveRecord::Migration
  def self.up
    add_attachment :videos, :clip
  end

  def self.down
    remove_attachment :videos, :clip
  end
end
