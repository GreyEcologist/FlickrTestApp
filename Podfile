use_frameworks!
platform :ios, '9.0'

def shared_pods
    pod 'ReactiveCocoa', '4.2.2'
    pod 'AsyncDisplayKit', '~> 1.9.80'
    pod 'FlickrKit'
end

target 'FlickrTestApp' do
    shared_pods
end

target 'FlickrTestAppTests' do
    inherit! :search_paths
    shared_pods
end

target 'FlickrTestAppUITests' do
    inherit! :search_paths
end
