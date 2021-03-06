#
#  Be sure to run `pod spec lint YHKit_Swift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "YHKit_Swift"
  spec.version      = "0.0.2"
  spec.summary      = "一个方便iOS开发的工具箱"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
                    YHKit是一个工具集合，涉及基础的抽象类，常用UI控件类的扩展等
                   DESC

  spec.homepage     = "https://github.com/championfu/YHKit_Swift"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #
  
  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "championfu" => "1026853439@qq.com" }
  # Or just: spec.author    = "championfu"
  # spec.authors            = { "championfu" => "1026853439@qq.com" }
  # spec.social_media_url   = "https://twitter.com/championfu"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  spec.platform     = :ios, "9.0"
  # Swift版本
  spec.swift_version = ["5.0", "5.1"]


  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/championfu/YHKit_Swift.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  # spec.source_files  = "Classes/**/*"
  spec.subspec 'Extension' do |ss|
    ss.subspec 'UIKit' do |sss|
      sss.source_files = "Classes/Extension/UIKit/*"
    end
    ss.subspec 'Other' do |sss|
      sss.source_files = "Classes/Extension/Other/*"
    end
    ss.subspec 'Foundation' do |sss|
      sss.source_files = "Classes/Extension/Foundation/*"
    end
  end

  spec.subspec 'Utilities' do |ss|
    ss.subspec 'UIKit' do |sss|
      sss.source_files = "Classes/Utilities/UIKit/*"
    end
    ss.subspec 'Other' do |sss|
      sss.source_files = "Classes/Utilities/Other/*"
    end
    ss.subspec 'Foundation' do |sss|
      sss.source_files = "Classes/Utilities/Foundation/*"
    end
  end

  spec.subspec 'Base' do |ss|
    ss.source_files = "Classes/Base/*"
  end

  spec.subspec 'Vendor' do |ss|
    ss.subspec 'SwiftyJSON' do |sss|
      sss.source_files = "Classes/Vendor/SwiftyJSON/*"
    end
    ss.subspec 'SnapKit' do |sss|
      sss.source_files = "Classes/Vendor/SnapKit/*"
    end
    ss.subspec 'HandyJSON' do |sss|
      sss.source_files = "Classes/Vendor/HandyJSON/*"
    end
  end

  # 公用头文件
  # spec.public_header_files = "Classes/YHKit-Swift-Bridging-Header.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # 加载图片资源
  #  spec.resources = "Classes/**/*.bundle"
  # spec.resource_bundles = {'Vendor' => ['Classes/Vendor/**/*.bundle']}
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
