# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def reactivePods
    pod 'ReactiveSwift', '~> 5.0'
    pod 'ReactiveCocoa', '~> 9.0.0'
    pod 'Moya/ReactiveSwift', '~> 13.0'
    pod 'Result', '~> 4.1'
end

def externalPods
    pod 'Moya', '~> 13.0'
end

target 'iTunesTest' do
  use_frameworks!
  inhibit_all_warnings!
  
  externalPods
  reactivePods
  
#  target 'iTunesTestTests' do
#      inherit! :search_paths
#  end
end

#target 'iTunesTestTests' do
#    inherit! :search_paths
#end


##bitcode enable
#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    target.build_configurations.each do |config|
#
#      # set valid architecture
#      config.build_settings['VALID_ARCHS'] = 'arm64 armv7 armv7s i386 x86_64'
#
#      # build active architecture only (Debug build all)
#      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
#
#      config.build_settings['ENABLE_BITCODE'] = 'NO'#'YES'
#
#      if config.name == 'Release' || config.name == 'Pro'
#          config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
#      else # Debug
#          config.build_settings['BITCODE_GENERATION_MODE'] = 'marker'
#      end
#
#      cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
#
#      if config.name == 'Release' || config.name == 'Pro'
#          cflags << '-fembed-bitcode'
#      else # Debug
#          cflags << '-fembed-bitcode-marker'
#      end
#
#      config.build_settings['OTHER_CFLAGS'] = cflags
#    end
#  end
#end
