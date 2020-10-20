import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:widget_module/constant/constant.dart';

import 'base_vmodel.dart';

abstract class BaseRefreshListVModel<T> extends BaseVModel {
  /// 页面数据
  List<T> list = [];

  /// 当前页码
  int _pageNum = 1;

  /// 分页数
  int _pageSize = Constant.PAGE_SIZE;

  /// 控制器
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  EasyRefreshController get easyRefreshController => _easyRefreshController;

  /// 下拉刷新数据
  refresh() {
    _pageNum = 1;
    Future<dynamic> result = loadListData(pageNum: _pageNum);
    List<T> data = [];
    result.then((value) {
      data = value;
      if (data.isEmpty) {
        _easyRefreshController.finishLoad(success: true, noMore: true);
        list.clear();
        setEmpty();
      } else {
        list.clear();
        list.addAll(data);

        /// 小于分页的数量，禁止加载更多
        _easyRefreshController.finishLoad(success: true, noMore: data.length < _pageSize);
        setSuccess();
      }
    }).catchError((error) {
      setError();
      Fluttertoast.showToast(msg: error);
    });
  }

  /// 加载更多
  loadMore() {
    Future<dynamic> result = loadListData(pageNum: ++_pageNum);
    List<T> data = [];
    result.then((value) {
      data = value;
      if (data.isEmpty) {
        _easyRefreshController.finishLoad(success: true, noMore: true);
      } else {
        list.addAll(data);

        /// 小于分页的数量，禁止加载更多
        _easyRefreshController.finishLoad(success: true, noMore: data.length < _pageSize);
      }
      setSuccess();
    }).catchError((error) {
      setError();
      Fluttertoast.showToast(msg: error);
    });
  }

  @override
  void dispose() {
    _easyRefreshController.dispose();
    super.dispose();
  }
}
