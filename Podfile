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

target 'iTunes' do
  use_frameworks!
  inhibit_all_warnings!
  
  externalPods
  reactivePods
end

target 'iTunesTests' do
  use_frameworks!
  inherit! :search_paths
  
  externalPods
  reactivePods
end
