Pod::Spec.new do |s|
  s.name         = "MVVMKit"
  s.version      = "0.0.2"
  s.summary      = "MVVM helpers"
  s.description  = "This is attempt to create couple of MVVM helpers for basic UIKit usage"
  s.homepage     = "https://github.com/ilidar/MVVMKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Denys Kotelovych" => "" }
  s.source       = { :git => "https://github.com/ilidar/MVVMKit.git", :tag => "0.0.1" }
  s.platform     = :ios, "8.3"
  s.source_files  = "MVVMKit", "MVVMKit/*.{h,m}"
  s.requires_arc = true
end
