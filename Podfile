use_frameworks!
platform :ios, '10.0'
inhibit_all_warnings!

def shared_pods
    pod 'Alamofire'
    pod 'NVActivityIndicatorView'
    pod 'QuickLayout'
    pod 'ReachabilitySwift'
    pod 'SnapKit'
    pod 'SwiftEntryKit'
end

target 'Currencies' do
    shared_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.2'
    end
    if target.name == 'Cache'
      target.build_configurations.each do |config|
        level = '-Osize'
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = level
      end
    end
  end
end
