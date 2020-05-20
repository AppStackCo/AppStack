#
# Be sure to run `pod lib lint AppStack.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppStack'
  s.version          = '0.1.0'
  s.summary          = 'A short description of AppStack.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gutoim/AppStack'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gutoim' => 'marius.gutoi@gmail.com' }
  s.source           = { :git => 'https://github.com/gutoim/AppStack.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'AppStack/Classes/**/*.swift'
  
  # s.resource_bundles = {
  #   'AppStack' => ['AppStack/Assets/*.png']
  # }
  s.resources = ['AppStack/Classes/**/*.{json,xib,storyboard}']

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Action', '~> 4.0.0'
  s.dependency 'Jelly', '~> 2.2.2'
  s.dependency 'lottie-ios', '~> 3.1.6'
  s.dependency 'SkyFloatingLabelTextField', '~> 3.8.0'
  s.dependency 'RxCocoa', '~> 5.1.1'
  s.dependency 'RxSwift', '~> 5.1.1'
  s.dependency 'RxDataSources', '~> 4.0.1'
  s.dependency 'RxBiBinding', '~> 0.2.5'
  s.dependency 'SPPermissions/Notification'
  # s.dependency 'SPPermissions/Contacts'
end
