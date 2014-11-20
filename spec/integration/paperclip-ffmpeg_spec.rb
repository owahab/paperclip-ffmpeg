require 'spec_helper'

describe 'Video' do
	it 'should be saved' do
		@video = Video.create!(clip: File.new(Dir.pwd + '/spec/support/1.mp4'))
		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.clip(:large).split('?')[0]).should be_true
		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.clip(:medium).split('?')[0]).should be_true
	end

	# this test blows.
	# it 'should not be converted/saved' do
	# 	@video = Video.create!(wrongClip: File.new(Dir.pwd + '/spec/support/1.mp4'))
	# 	File.exist?(Dir.pwd + '/spec/dummy/public' + @video.wrongClip(:large).split('?')[0]).should be_false
	# end

	context 'auto_rotate is specified as portrait' do
		it 'should rotate a landscape video to be portrait' do
			@video = Video.create!(portraitClip: File.new(Dir.pwd + '/spec/support/2.mp4'))
			expect(@video.portraitClip_meta['rotate']).to eq("0")
			fh = File.open(Dir.pwd + '/spec/dummy/public' + @video.portraitClip(:jpg).split('?')[0])
		    size = ImageSize.new(fh.read)
		    expect(size.w.to_f).to be <= size.h.to_f
		end

		it 'should keep a portrait video as portrait' do
			@video = Video.create!(portraitClip: File.new(Dir.pwd + '/spec/support/3.mp4'))
			expect(@video.portraitClip_meta['rotate']).to eq("90")
			fh = File.open(Dir.pwd + '/spec/dummy/public' + @video.portraitClip(:jpg).split('?')[0])
		    size = ImageSize.new(fh.read)
		    expect(size.w.to_f).to be <= size.h.to_f
		end
	end

	context 'auto_rotate is specified as landscape' do
		it 'should keep a landscape video as landscape' do
			@video = Video.create!(landscapeClip: File.new(Dir.pwd + '/spec/support/2.mp4'))
			expect(@video.landscapeClip_meta['rotate']).to eq("0")
			fh = File.open(Dir.pwd + '/spec/dummy/public' + @video.landscapeClip(:jpg).split('?')[0])
		    size = ImageSize.new(fh.read)
		    expect(size.w.to_f).to be >= size.h.to_f
		end

		it 'should rotate a portrait video as landscape' do
			@video = Video.create!(landscapeClip: File.new(Dir.pwd + '/spec/support/3.mp4'))
			expect(@video.landscapeClip_meta['rotate']).to eq("90")
			fh = File.open(Dir.pwd + '/spec/dummy/public' + @video.landscapeClip(:jpg).split('?')[0])
		    size = ImageSize.new(fh.read)
		    expect(size.w.to_f).to be >= size.h.to_f
		end
	end

	context 'Exiftool is specified for metadata' do
		it 'uses Exiftool' do
			@video = Video.create!(exiftoolClip: File.new(Dir.pwd + '/spec/support/2.mp4'))
			expect(@video.exiftoolClip_meta['AudioFormat']).to_not be_nil
		end

		it 'uses Exiftool and has auto_rotate' do
			@video = Video.create!(exiftoolClipRotate: File.new(Dir.pwd + '/spec/support/2.mp4'))
			expect(@video.exiftoolClipRotate_meta['rotate']).to eq("0")
		end
	end
end

# describe 'Thumbnail file' do

# 	it 'should exist' do
# 		@video = Video.create!(clip_thumb_normal: File.new(Dir.pwd + '/spec/support/1.mp4'))
# 		puts @video.clip_thumb_normal(:thumb)
# 		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.clip_thumb_normal(:large).split('?')[0]).should be_true
# 	end

# 	# this test blows.
# 	it 'should not exist' do
# 		@video = Video.create!(clip_thumb_bad_extension: File.new(Dir.pwd + '/spec/support/1.mp4'))
# 		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.clip_thumb_bad_extension(:thumb).split('?')[0]).should be_false
# 	end

# 	it 'should be empty' do
# 		@video = Video.create!(clip_thumb_exceed: File.new(Dir.pwd + '/spec/support/1.mp4'))
# 		File.size(Dir.pwd + '/spec/dummy/public' + @video.clip_thumb_exceed(:thumb).split('?')[0]).to_f.should be 0.0
# 	end

# 	it 'should be 100*100' do
# 		@video = Video.create!(clip_thumb_normal: File.new(Dir.pwd + '/spec/support/1.mp4'))
# 		fh = File.open(Dir.pwd + '/spec/dummy/public' + @video.clip_thumb_normal(:thumb).split('?')[0])
# 	    size = ImageSize.new(fh.read)
# 	    size.w.to_f.should be 100.0
# 	    size.h.to_f.should be 100.0
# 	end

# end
