Pod::Spec.new do |s|
  s.name             = 'AppyKit'
  s.version          = '1.5'
  s.summary          = 'UIKit Helpers.'
 
  s.description      = <<-DESC
UIKit helpers and design patterns
                       DESC
 
  s.homepage         = 'https://github.com/appyist/appykit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Emirhan erdogan' => 'emirhan@appy.ist' }
  s.source           = { :git => 'https://github.com/appyist/appykit.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'AppyKit/**/*.swift'
  s.resources = 'AppyKit/**/*.{xib,strings}'
end