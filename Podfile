# Uncomment the next line to define a global platform for your project
  platform :ios, '13.5'

target 'YoutubeSearchApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for YoutubeSearchApp
  
  plugin 'cocoapods-keys', {
    :project => 'YoutubeSearchApp',
    :keys => [
      'youtubeDataAPIKey'
    ]
  }

  # Images frameworks

  pod 'SDWebImage'
 
  #  Animation frameworks

  pod 'SegementSlide'

  # Networking frameworks

  pod 'Alamofire'

  # JSON frameworks

  pod 'SwiftyJSON'

  # add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'
  # add pods for any other desired Firebase products
  # https://firebase.google.com/docs/ios/setup#available-pods

  target 'YoutubeSearchAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
