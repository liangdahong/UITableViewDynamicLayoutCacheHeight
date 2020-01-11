//
//  UITableViewDynamicLayoutMacro.h
//  UITableView-BMDynamicLayout
//
//  Created by liangdahong on 2020/1/6.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#ifndef UITableViewDynamicLayoutMacro_h
#define UITableViewDynamicLayoutMacro_h

#ifndef BMTABLEVIEWVIEW_DYNAMICLAYOUT_DYNAMIC_PROPERTY_OBJECT
#define BMTABLEVIEWVIEW_DYNAMICLAYOUT_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif

#define KIS_VERTICAL (UIScreen.mainScreen.bounds.size.height > UIScreen.mainScreen.bounds.size.width)

#endif
