#
#  Be sure to run `pod spec lint JFKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "JFKit"
  s.version      = "1.0.0"
  s.summary      = "some codes by myself"

  s.description = %{
    just for ios develop, for easy and faster to develop program
  }

  s.homepage     = "https://github.com/JoyFate/JFKit.git"

  s.license      = "MIT"

  s.author             = { "hudan" => "1017hudan@163.com" }

  s.platform     = :ios, '8.0'

  s.source       = { :git => "https://github.com/JoyFate/JFKit.git", :tag => "#{s.version}" }

  s.source_files = 'JFKit/JFKit/Codes/*.{h,m}'
  s.resources = "JFKit/JFKit/Resources/**/*.png"

  s.frameworks = "Foundation", "UIKit", "AVFoundation", "CoreLocation", "LocalAuthentication"
  s.library = "c++"


  s.requires_arc = true


  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "Masonry", "~> 1.0.1"
  s.dependency "SDWebImage", "~> 3.7.6"
  s.dependency "MBProgressHUD", "~> 0.9.2"
  s.dependency "MJRefresh", "~> 3.1.12"

s.subspec 'Headers' do |ss|
    ss.source_files = 'JFKit/JFKit/*.{h}'
end

s.subspec 'Category' do |category|
    category.source_files = 'JFKit/JFKit/Codes/Category/**/*.{h,m}'
end

s.subspec 'FunctionControl' do |functionControl|
    functionControl.source_files = 'JFKit/JFKit/Codes/FunctionControl/**/*.{h,m}'
end

s.subspec 'UIControl' do |uiControl|
    uiControl.source_files = 'JFKit/JFKit/Codes/UIControl/**/*.{h,m}'
end

s.subspec 'Tool' do |tool|
    tool.source_files = 'JFKit/JFKit/Codes/Tool/**/*.{h,m,mm}','JFKit/JFKit/Codes/Vender/**/*.{h,m}'
end


end
