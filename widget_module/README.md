# Android项目集成flutter
**flutter模块可以单独提出到module中，便于后期Android和IOS项目共同使用flutter**
### 安卓原生项目集成Flutter项目
1. 先创建一个安卓原生项目
2. 使用New Module-> Flutter Module 
3. 编译完成

### 跳转到Flutter界面，带FutureBuilder实现数据列表的加载，刷新，加载更多
1. 第一种方式，withNewEngine，不推荐使用，因为跳转的时候需要初始化，会出现短暂的黑屏
2. 第二种方式，现在MyApplication中初始化FlutterEngine，然后使用的时候在从缓存中去获取，缺点是初始化时候指定跳转的界面，跳转的时候不可以修改

### flutter调用原生安卓中方法（flutter跳转到原生Activity）
1. getNativeImage
2. toActivity