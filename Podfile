platform :ios, '7.0'

pod 'AFNetworking'
pod 'Facebook-iOS-SDK'
pod 'Parse'
pod 'ParseFacebookUtils'
pod 'SWRevealViewController', '=2.1.0'

post_install do |installer|
  if system("which xcproj > /dev/null 2>&1")
    puts "Found xcproj"
  elsif not system("brew install xcproj")
    puts %Q{
    [!] Require xcproj to modify Xcode project files. Please install homebrew and run 'pod install' again.
    For more information:
    * http://brew.sh/
    * https://github.com/CocoaPods/Xcodeproj
    }
  end
end
