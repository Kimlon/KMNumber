#
# Be sure to run `pod lib lint KMNumber.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KMNumber'
  s.version          = '0.1.6'
  s.summary          = 'KMNumber用于精确计算'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
KMNumber是一个用于精确计算的库，来数字位数和精度较高的算数运算。
                       DESC

  s.homepage         = 'https://github.com/Kimlon/KMNumber'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kimlon' => 'lelebabyboy@tom.com' }
  s.source           = { :git => 'https://github.com/Kimlon/KMNumber.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'KMNumber/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KMNumber' => ['KMNumber/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
