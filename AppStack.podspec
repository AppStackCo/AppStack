#
# Be sure to run `pod lib lint AppStack.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppStack'
  s.version          = '0.5.0'
  s.summary          = 'Smart framework used to speed up building of iOS applications'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  AppStack contains coordinators, styling, etc. It is built with RxSwift.
  DESC

  s.homepage         = 'https://github.com/AppStackCo/AppStack'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marius Gutoi' => 'marius.gutoi@gmail.com' }
  s.source           = { :git => 'https://github.com/AppStackCo/AppStack.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'

  s.source_files = 'AppStack/Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'AppStack' => ['AppStack/Assets/*.png']
  # }
  s.resources = ['AppStack/Classes/**/*.{json,xib,storyboard,xcassets}']

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'Overture'
  s.dependency 'Action'
  s.dependency 'Jelly'
  s.dependency 'lottie-ios'
  s.dependency 'SkyFloatingLabelTextField'
  s.dependency 'RxCocoa'
  s.dependency 'RxSwift'
  s.dependency 'RxDataSources'
  s.dependency 'RxBiBinding'
  s.dependency 'SPPermissions/Notification'
  s.dependency 'SPPermissions/Contacts'
end
