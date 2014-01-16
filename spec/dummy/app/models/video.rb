class Video < ActiveRecord::Base

	has_attached_file :clip, :styles => {
    :medium => { :geometry => "640x480", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} }
  }, :processors => [:ffmpeg]

  has_attached_file :wrongClip, :styles => {
    :large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 3000}} }
  }, :processors => [:ffmpeg]

  has_attached_file :clip_thumb_exceed, :styles => {
    :large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10}
  }, :processors => [:ffmpeg]

  has_attached_file :clip_thumb_normal, :styles => {
    :large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 0}
  }, :processors => [:ffmpeg]

  has_attached_file :clip_thumb_negative, :styles => {
  	:large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'jpg', :time => -10}
  }, :processors => [:ffmpeg]

  has_attached_file :clip_thumb_bad_extension, :styles => {
  	:large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :thumb => { :geometry => "100x100#", :format => 'foo', :time => 0}
  }, :processors => [:ffmpeg]

end

