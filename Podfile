# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'ParticleAuthDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
source 'https://github.com/CocoaPods/Specs.git'
  use_frameworks!
  # AuthSDK need ParticleNetworkBase and ParticleAuthService
  pod 'ParticleNetworkBase', '0.12.0'
  pod 'ParticleAuthService', '0.12.0'

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
  
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
         end
    end
  end
  
end
