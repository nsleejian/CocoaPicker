Pod::Spec.new do |s|
   s.name         = "CocoaPicker"
   s.version      = "0.1.1"
   s.summary      = "仿 QQ 图片选择器"
   s.homepage     = "https://github.com/thebookofleaves/CocoaPicker"
   s.license      = "MIT"
   s.authors      = { 'Cocoa Lee' => 'cocoaleespring@gmail.com'}
   s.platform     = :ios, "7.0"
   s.source       = { :git => "https://github.com/thebookofleaves/CocoaPicker.git", :tag => s.version }
   s.source_files = 'Class/*.{h,m}'
   s.requires_arc = true end
