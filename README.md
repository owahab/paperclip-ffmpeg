Paperclip FFMPEG
================

Adding video handling to Paperclip via ffmpeg.
This gem has been tested under Linux and Mac OS X, YMMV under Windows.

Requirements
------------

FFMPEG must be installed and Paperclip must have access to it. To ensure
that it does, on your command line, run `which ffmpeg`.
This will give you the path where ffmpeg is installed. For
example, it might return `/usr/local/bin/ffmpeg`.

Then, in your environment config file, let Paperclip know to look there by adding that 
directory to its path.

In development mode, you might add this line to `config/environments/development.rb)`:

    Paperclip.options[:command_path] = "/usr/local/bin/"

Installation
------------

Include the gem in your Gemfile:

    gem "paperclip-ffmpeg"

Quick Start
-----------

In your model:

    class User < ActiveRecord::Base
      has_attached_file :avatar, :styles => { 
          :medium => { :geometry => "640x480", :format => 'flv' }
          :thumb => { :geometry => "100x100#", :format => 'jpg', :time => 10 }
        }, :processors => [:ffmpeg]
    end

This will produce:

1. A transcoded `:medium` FLV file with the requested dimensions if they will match the aspect ratio of the original file, otherwise, width will be maintained and height will be recalculated to keep the original aspect ration.
2. A screenshot `:thumb` with the requested dimensions regardless of the aspect ratio.

You may optionally add `<attachment>_meta` to your model and paperclip-ffmpeg will add information about the processed video.

Streamable Encoding
-------------------

When ffmpeg produces mp4 files, it places the moov atom at the end which makes it unsuitable for streaming to mobile devices (i.e. Android and iPhone). In order to move the moov atom to the beginning of the produced file, it must be processed with qtfaststart. See [danielgtaylor/qtfaststart](https://github.com/danielgtaylor/qtfaststart) for setup instructions.

In your model:

    class Lesson < ActiveRecord::Base
      has_attached_file :video, :styles => {
          :mobile => {:geometry => "400x300", :format => 'mp4', :streamable => true}
      }, :processors => [:ffmpeg]
    end
    
This will automatically process the produced mp4 file with qtfaststart, making it suitable for streaming. `:streamable` should only be used on .mp4 and .mov files.

License
-------

Licensed under BSD license.