# BZComplexListDemo

2020.7.8

master 版本构建完毕类似微博首页列表，完全原生方法处理，图片加载，tableview的绘制全部采用原生方法

性能测试：instrument 测试得到 fps基本没有超过30的时候，Time Profile测试经过6秒才正常启动，耗时全部在主线程上。

因为并未使用GCD等手段因此CPU使用率还算正常，总共运行了30秒，主线程耗时6秒。滑动十分卡顿。

详情见测试文件
