import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:widget_module/util/log_util.dart';

import 'constant/config.dart';
import 'constant/constant.dart';
import 'net/http_manager.dart';
import 'net/lcfarm_log_interceptor.dart';
import 'page/home_page.dart';
import 'page/second_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Config.fill(debug: Constant.Debug, dbName: "millet", apiUrl: Constant.BaseUrl);
  /// 初始化日志
  LogUtil.init(isDebug: Config.inst.debug, tag: "MilletTag");
  /// 初始化网络
  HttpManager().init(baseUrl: Config.inst.apiUrl, interceptors: [LcfarmLogInterceptor()]);
  /// 初始化sp
  // await SpUtil().init();
  /// 初始化刷新
  await initRefresh();
  runApp(MyApp());
}

Future initRefresh() async {
  /// 初始化刷新样式
  EasyRefresh.defaultHeader = ClassicalHeader(
      refreshText: "下拉刷新",
      refreshReadyText: "释放刷新",
      refreshingText: "正在刷新",
      refreshedText: "刷新完成",
      infoText: '更新于 %T');
  EasyRefresh.defaultFooter = ClassicalFooter(
      loadText: "下拉加载更多",
      loadReadyText: "释放加载更多",
      loadingText: "加载中",
      loadedText: "加载完成",
      infoText: '更新于 %T');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor:Colors.white,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => MyHomePage(title: "Flutter Demo Home Page",),
        "/second": (context) => SecondPage(state: 10,),
      },
    );
  }
}
