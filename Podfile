# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'MovieList'
use_frameworks!
def search
    pod 'Alamofire'
    pod 'PKHUD'
    pod 'SDWebImage'
end

target 'Search' do
    project 'Search/Search.xcodeproj'
    search
end

target 'SearchTests' do
    project 'Search/Search.xcodeproj'
    search
end

target 'MovieList' do
    project 'MovieList/MovieList.xcodeproj'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for MovieList
  pod 'Alamofire'
  pod 'SDWebImage'
  pod 'PKHUD'
  search
end
