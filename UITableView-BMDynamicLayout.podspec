Pod::Spec.new do |s|
s.name         = 'UITableView-BMDynamicLayout'
s.version      = '3.0.6'
s.summary      = '🖖 Template auto layout cell for automatically UITableViewCell UITableViewHeaderFooterView calculating and cache height framework.'
s.homepage     = 'https://github.com/liangdahong/UITableView-BMDynamicLayout'
s.license      = 'MIT'
s.authors      = {'liangdahong' => 'ios@liangdahong.com'}
s.platform     = :ios, '9.0'
s.source       = {:git => 'https://github.com/liangdahong/UITableView-BMDynamicLayout.git', :tag => s.version}
s.requires_arc = true

    s.subspec 'Private' do |ss|
        ss.source_files = 'UITableView-BMDynamicLayout/Sources/UITableView-BMDynamicLayout/Private/*.{h,m}'
    end

    s.subspec 'Public' do |ss|
        ss.source_files = 'UITableView-BMDynamicLayout/Sources/UITableView-BMDynamicLayout/Public/*.{h,m}'
    end

end
