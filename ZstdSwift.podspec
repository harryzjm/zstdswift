Pod::Spec.new do |s|
  s.name         = 'ZstdSwift'
  s.version      = '1.0.0'
  s.license      = { :type => 'BSD', :file => 'LICENSE' }
  s.summary      = 'swift category for zstandard compression.'
  s.homepage     = 'https://github.com/harryzjm/zstd'
  s.authors      = { 'hares' => 'https://github.com/harryzjm' }
  s.source       = { :git => 'https://github.com/harryzjm/zstd.git', :tag => s.version, :submodules => true }
  s.swift_version = "5.0"

  s.ios.deployment_target  = '13.0'
  # s.osx.deployment_target  = '14.0'

  s.source_files = 'source/*.{swift,h}'
  s.public_header_files = 'source/*.h'

  s.dependency "libzstd", '~> 1.5.5'
end
