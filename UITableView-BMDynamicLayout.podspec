Pod::Spec.new do |s|
s.name         = 'UITableView-BMDynamicLayout'
s.version      = '3.1.5'
s.summary      = '🖖 Template auto layout cell for automatically UITableViewCell UITableViewHeaderFooterView calculating and cache height framework.'
s.homepage     = 'https://github.com/liangdahong/UITableView-BMDynamicLayout'
s.license      = 'MIT'
s.authors      = {'liangdahong' => 'ios@liangdahong.com'}
s.platform     = :ios, '9.0'
s.source       = {:git => 'https://github.com/liangdahong/UITableView-BMDynamicLayout.git', :tag => s.version}
s.requires_arc = true
s.source_files = 'Sources/UITableView-BMDynamicLayout/**/*.{h,m}'
end
