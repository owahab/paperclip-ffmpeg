require 'spec_helper'

describe 'Video' do
	it 'should be save' do
		@video = Video.create(clip: File.new(Dir.pwd + '/spec/support/1.mp4'))
		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.clip(:large).split('?')[0]).should be_true
		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.clip(:medium).split('?')[0]).should be_true
	end

	it 'should not be converted/saved' do
		@video = Video.create(wrongClip: File.new(Dir.pwd + '/spec/support/1.mp4'))
		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.wrongClip(:large).split('?')[0]).should be_false
	end
end

describe 'Thumbnail file' do

	it 'should exist' do
		@video = Video.create(clip_thumb_normal: File.new(Dir.pwd + '/spec/support/1.mp4'))
		puts @video.clip_thumb_normal(:thumb)
		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.clip_thumb_normal(:large).split('?')[0]).should be_true
	end

	it 'should not exist' do
		@video = Video.create(clip_thumb_bad_extension: File.new(Dir.pwd + '/spec/support/1.mp4'))
		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.clip_thumb_bad_extension(:thumb).split('?')[0]).should be_false
	end

	it 'should be empty' do
		@video = Video.create(clip_thumb_exceed: File.new(Dir.pwd + '/spec/support/1.mp4'))
		File.size(Dir.pwd + '/spec/dummy/public' + @video.clip_thumb_exceed(:thumb).split('?')[0]).to_f.should be 0.0
	end

	it 'should be 100*100' do
		@video = Video.create(clip_thumb_normal: File.new(Dir.pwd + '/spec/support/1.mp4'))
		fh = File.open(Dir.pwd + '/spec/dummy/public' + @video.clip_thumb_normal(:thumb).split('?')[0])
    size = ImageSize.new(fh.read)
    size.w.to_f.should be 100.0
    size.h.to_f.should be 100.0
	end

end
