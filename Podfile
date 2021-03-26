# Uncomment this line to define a global platform for your project
platform :ios, '11.0'
source 'https://cdn.cocoapods.org/'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'Balad' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
   pod 'Moya'
   #pod 'PromiseKit', '~> 6.8'
   #pod 'ObjectMapper' ,'~> 4.2.0'

  target 'BaladTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BaladUITests' do
    # Pods for testing
  end

end


post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
      end
      pi.pods_project.root_object.attributes['LastSwiftMigration'] = 9999
      pi.pods_project.root_object.attributes['LastSwiftUpdateCheck'] = 9999
      pi.pods_project.root_object.attributes['LastUpgradeCheck'] = 9999
    end
end
