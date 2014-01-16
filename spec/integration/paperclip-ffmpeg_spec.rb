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
		puts '*****************************************'
		puts @video.clip_thumb_normal(:thumb)
		File.exist?(Dir.pwd + '/spec/dummy/public' + @video.clip_thumb_normal(:large).split('?')[0]).should be_true
	end

	it 'should not exist' do
		pending 'Thumb extension is not valid'
	end

	it 'should be empty' do
		pending 'Thumb time exceeds the video'
	end

	it 'should be 100*100' do
		pending 'Thumb dimension needs to be 100*100'
	end

	it 'should throw negative_value_exception' do
		pending 'Thumb time with negative value'
	end

end
