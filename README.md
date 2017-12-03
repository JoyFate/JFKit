# JFKit


使用:
    pod 'JFKit', :git => "https://github.com/huxiadan/JFKit.git"


引用第三方:
    Masonry
    SDWebImage
    MBProgressHUD
    MJRefresh


共分为四大类:
JFCategory
    提供 Foundation 和 UIKit 的一些分类:
        NSArray                 防止数组越界导致奔溃, 给不可变数组追加数组
        NSArributedString       设置行间距的封装
        NDDate                  根据字符串格式化成日期
        NSDictionary            获取字典的 key 对应的值,防止 value 值为 null 导致奔溃
        NSMutableArray          对插入 nil 对象做了防止崩溃处理,在 DEBUG 环境下会抛出崩溃异常
        NSMutableDictionary     同上
        NSString                方便计算文字大小的 api
        NSUserDefaults          方便NSUserDefaults的使用, 获取的值进行非 nil 处理

JFFunctionControl
    提供一些封装的功能控件: 
        Base                    封装的基类（UINavigationViewController， UIViewController）
        JFPageViewController    多个控制器的segment
        AutoButtonView          存放多个按钮的容器视图,按钮自动换行
        HUB                     对简单的 MBProgressHUD的封装
        Marquee                 跑马灯效果的视图
        NumberView              带一个加一个减按钮Label 显示的视图
        OptionSlider            多个按钮的容器,横条样式,类似网易新闻的顶部多个分类按钮,支持按钮等距离,按钮等宽
        Refresh                 对 MJRefresh 的简单封装
        ReviewsPhotoView        支持最多4张图片的图片选择显示视图,用于发表评价
        JFCardView              类似探探的卡片效果,左右滑动动画
        StarView                五星视图,支持星星图片自定义,星星可点击与不可点击
        TouchID                 指纹验证的封装
        Location                定位,反编译地名的封装
        localNoti               本地通知的分钟
        Cache                   基于 SDWebImage 的缓存及本地缓存的功能封装,用于,获取缓存大小清除缓存等功能
        等等

JFUIControl
    提供一些 UIKit 的控件子类: 
        JFButton                属性设置代替方法调用改变状态显示
        JFLabel                 可设置行间距,计算文字高度等
        JFImageView             高效的设置圆角图片
        JFTabbarController      自定义的 tabBarController,基本满足项目开发
        JFTextField             一个属性设置内容左边距等
        JFTextView              支持设置 placeholder 等
        JFWebView               方便的设置 cookie 等

JFTools
    提供一些工具类:
        图片处理
        简单用户管理
        颜色工具类
        设备信息,功能工具类
        加密工具类
        文件工具类
        单利工具类
        验证工具类
