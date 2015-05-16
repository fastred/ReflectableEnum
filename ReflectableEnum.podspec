Pod::Spec.new do |s|
  s.name             = "ReflectableEnum"
  s.version          = "0.1.0"
  s.summary          = "Reflection for enums in Objective-C"
  s.homepage         = "https://github.com/fastred/ReflectableEnum"
  s.license          = 'MIT'
  s.author           = { "Arkadiusz Holko" => "fastred@fastred.org" }
  s.social_media_url = "https://twitter.com/arekholko"
  s.source           = { :git => "https://github.com/fastred/ReflectableEnum.git", :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'

  s.requires_arc = true
  s.source_files = 'ReflectableEnum/*.{h,m}'
  s.public_header_files = 'ReflectableEnum/*.h'
end
