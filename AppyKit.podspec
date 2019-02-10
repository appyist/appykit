Pod::Spec.new do |s|
  s.name             = 'AppyKit'
  s.version          = '1.4'
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
  s.resource_bundles = {
      'PlacerholderXibs' => ['AppyKit/Protocols/StatableController/Default\ Placeholders/LoadingPlaceholderView/*.xib',
                             'AppyKit/Protocols/StatableController/Default\ Placeholders/ErrorPlaceholderView/*.xib',
                             'AppyKit/Protocols/StatableController/Default\ Placeholders/EmptyPlaceholderView/*.xib'],
      'Localizations' => ['AppyKit/Resources/Localizables/*.lproj/*.{xib,strings}']
  }
end