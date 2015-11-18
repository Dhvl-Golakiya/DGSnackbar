#
# Be sure to run `pod lib lint DGSnackbar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "DGSnackbar"
s.version          = "0.1.1"
s.summary          = "A material Design snackbar with action button for iOS."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
s.description      = <<-DESC
Currently snackbar is using in Android application and also insome iOS application like Gmail.
Using DGSnackbar, you can implement snackbar in your iOS application. Snackbar has also setting image for action button feature. So you can set image on action button instead of only text.
DESC

s.homepage         = "https://github.com/Dhvl-Golakiya/DGSnackbar"
# s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "Dhvl-Golakiya" => "dhvl.golakiya@gmail.com" }
s.source           = { :git => "https://github.com/Dhvl-Golakiya/DGSnackbar.git", :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/Dhvl_Golakiya'

s.platform     = :ios, '8.0'
s.requires_arc = true

s.source_files = 'Pod/Classes/**/*'
s.resource_bundles = {
'DGSnackbar' => ['Pod/Assets/*.png']
}

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
