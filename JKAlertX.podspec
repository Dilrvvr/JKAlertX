#
# Be sure to run `pod lib lint JKAlertX.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JKAlertX'
  s.version          = '2.0.9'
  s.summary          = 'An AlertView for iOS. Support User Customization Perfectly. iOS弹框，包含alert/actionsheet/collectionSheet/HUD四种样式。自动适配横屏，完美支持自定义。 支持链式语法，简单优雅！'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

# s.description      = <<-DESC
# TODO: Add long description of the pod here.
# DESC

  s.homepage         = 'https://github.com/Jacky-An/JKAlertX.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Albert" => "jkdev123cool@gmail.com" }
  s.source           = { :git => "https://github.com/Jacky-An/JKAlertX.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JKAlertX/Classes/**/*'
  
  s.framework  = "UIKit", "Foundation"
  
  # s.resource_bundles = {
  #   'JKAlertX' => ['JKAlertX/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
