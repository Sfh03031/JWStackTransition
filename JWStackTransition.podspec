#
# Be sure to run `pod lib lint JWStackTransition.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JWStackTransition'
  s.version          = '0.1.6'
  s.summary          = 'A swift library that provides transition animations for navigation controllers, offering various transition effects such as clocks, fences, flips, folds and so on.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  JWStackTransition is a library that provides transition animations for navigation controllers, offering various transition effects such as clocks, fences, flips, folds and so on.
  
  It currently has many different kind of transition animation types, most of them can be customized.
                       DESC

  s.homepage         = 'https://github.com/Sfh03031/JWStackTransition'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sfh03031' => 'sfh894645252@163.com' }
  s.source           = { :git => 'https://github.com/Sfh03031/JWStackTransition.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_versions   = '5'
  s.platform         = :ios, '12.0'

  s.source_files = 'JWStackTransition/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JWStackTransition' => ['JWStackTransition/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
