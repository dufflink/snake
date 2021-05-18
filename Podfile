inhibit_all_warnings!
use_frameworks!

target 'Snake' do
  platform :ios, '11'
  pod 'Haptico'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
