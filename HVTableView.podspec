#
# Be sure to run `pod lib lint HVTableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HVTableView'
  s.version          = '0.2.1'
  s.summary          = 'UITableView with expand/collapse feature'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a subclass of UITableView with expand/collapse feature that comes useful in many scenarios. The developer can save a lot of time using an expand/collapse tableView instead of creating a detail viewController for each cell. Consequently the details of each cell can be displayed right on the same table without switching to another view.
                       DESC

  s.homepage         = 'https://github.com/innovian/HVTableView'
  # s.screenshots     = 'https://raw.githubusercontent.com/innovian/HVTableView/master/Screens/screenshot.jpg'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Innovian' => 'innovian.com' }
  s.source           = { :git => 'https://github.com/innovian/HVTableView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/innovian'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HVTableView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HVTableView' => ['HVTableView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
