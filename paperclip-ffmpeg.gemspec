# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "paperclip-ffmpeg"
  s.version     = '0.6.4'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Omar Abdel-Wahab"]
  s.email       = ["owahab@gmail.com"]
  s.homepage    = "http://github.com/owahab/paperclip-ffmpeg"
  s.summary     = %q{Process your attachments with FFMPEG}
  s.description = %q{Process your attachments with FFMPEG}

  s.rubyforge_project = "paperclip-ffmpeg"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('paperclip', '>=2.3.8')
end
