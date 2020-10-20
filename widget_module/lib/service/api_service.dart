import 'dart:async';
import 'dart:convert';

import 'package:widget_module/base/base_list_bean.dart';
import 'package:widget_module/bean/user_task_list_bean.dart';
import 'package:widget_module/net/http_manager.dart';

class ApiService {

  /// test
  // Future<List<ArticleBean>> getInfo() async {
  //   Completer<List<ArticleBean>> completer = Completer();
  //   HttpManager().get(
  //       url: "wxarticle/chapters/json",
  //       successCallback: (value) {
  //         List responseJson = json.decode(json.encode(value));
  //         List<ArticleBean> modelTestList = responseJson.map((m) => new ArticleBean.fromJson(m)).toList();
  //         completer.complete(modelTestList);
  //       },
  //       errorCallback: (value) {
  //         completer.completeError(value.message);
  //       },
  //       tag: "");
  //   return completer.future;
  // }

  /// 列表
  Future<BaseListBean<UserTaskList>> getUserTaskList({int pageNum, int pageSize = 10}) async {
    Map<String, dynamic> params = new Map();
    if(pageNum != null) {
      params['pageNum'] = pageNum;
    }
    if(pageSize != null) {
      params['pageSize'] = pageSize;
    }
    Completer<BaseListBean<UserTaskList>> completer = Completer();
    HttpManager().post(
        url: "freework-api/api/merchantTask/getMerchantTaskPage",
        data: params,
        successCallback: (value) {
          Map map = json.decode(json.encode(value));
          BaseListBean baseListBean = BaseListBean.fromJson(map);
          List<UserTaskList> modelTestList = baseListBean.list.map((m) => new UserTaskList.fromJson(m)).toList();
          completer.complete(BaseListBean(list: modelTestList, pageNum: baseListBean.pageNum, pageSize: pageSize, pages: baseListBean.pages));
        },
        errorCallback: (value) {
          completer.completeError(value.message);
        },
        tag: "");
    return completer.future;
  }

}
