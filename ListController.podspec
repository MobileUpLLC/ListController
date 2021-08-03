Pod::Spec.new do |spec|

  spec.name         = "ListController"
  spec.version      = "1.0.4"
  spec.summary      = "An abstraction layer to deal with listable data"
  spec.description  = "Provides an abstraction layer to deal with listable data. It's a simpler and faster way to build table views on top of this than from scratch."
  spec.homepage     = "https://github.com/MobileUpLLC/ListController"

  spec.license      = "MIT"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "MobileUp iOS Team" => "hello@mobileup.ru" }

  spec.platform     = :ios, "13.0"
  spec.ios.frameworks = 'UIKit'
  spec.swift_version = ['5']
  
  spec.source = { :git => 'https://github.com/MobileUpLLC/ListController.git', :tag => spec.version.to_s }
  spec.source_files  = "Source/", "Source/**/*.{swift}"
end
