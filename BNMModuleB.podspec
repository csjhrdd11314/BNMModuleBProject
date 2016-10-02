#
# Be sure to run `pod lib lint Network.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "BNMModuleB"
s.version          = "0.0.1"
s.summary          = "BNMModuleB."
s.description      = <<-DESC
                        This pod is a module which contains two testcase,
                        the first one is about api request,the second one
                        is about the login.
                      DESC
s.homepage         = "http://www.baidu.com"
s.license          = 'MIT'
s.author           = "chenshuijin@baidu.com"
s.source           = { :git => "https://github.com/csjhrdd11314/BNMLogin.git", :tag => s.version }
s.platform     = :ios, '8.0'
s.requires_arc = true
s.public_header_files = "**/*.h"
s.source_files = "**/*.{h,m}"
s.dependency 'BNMLogin'
s.dependency 'BNMNetwork'
s.dependency 'BNMCategory'
s.dependency 'BNMLoginResource'
s.dependency 'BNMMediator'
s.dependency 'HandyFrame'
s.dependency 'SVProgressHUD'



end
