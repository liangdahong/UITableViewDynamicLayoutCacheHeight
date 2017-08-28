Pod::Spec.new do |s|
s.name         = 'BMTemplateLayoutCell'
s.version      = '1.0.3'
s.summary      = 'Template autolayout cell for automatically UITableViewCell UITableViewHeaderFooterView height calculating'
s.homepage     = 'https://github.com/asiosldh/UITableView-BMTemplateLayoutCell'
s.license      = 'MIT'
s.authors      = {'idhong' => 'asiosldh@163.com'}
s.platform     = :ios, '6.0'
s.source       = {:git => 'https://github.com/asiosldh/UITableView-BMTemplateLayoutCell.git', :tag => s.version}
s.source_files = 'BMTemplateLayoutCell/**/*.{h,m}'
s.requires_arc = true
end
