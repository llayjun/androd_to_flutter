import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:widget_module/base/base_list_bean.dart';
import 'package:widget_module/bean/user_task_list_bean.dart';
import 'package:widget_module/channel/channel_util.dart';
import 'package:widget_module/constant/app_colors.dart';
import 'package:widget_module/constant/constant.dart';
import 'package:widget_module/service/api_service.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key key, this.state}) : super(key: key);

  final int state;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  // 数据
  ApiService apiService = ApiService();

  // 列表对象
  List<UserTaskList> taskList = [];

  // controller
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  // 默认页数
  int index = 1;

  // future，用于防止setState()重置builder的future
  Future future;

  // 是否是初始化数据
  bool initData = true;

  @override
  void initState() {
    super.initState();
    future = getData(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black,), onPressed: null),
          title: Text("任务列表"),
          centerTitle: true,
        ),
        body: FutureBuilder<BaseListBean<UserTaskList>> (
            future: future,
            builder: (context, snap) {
              switch(snap.connectionState) {
                case ConnectionState.waiting:
                  return new Center(child: CircularProgressIndicator(),);
                  break;
                case ConnectionState.done:
                    if(snap.hasData && initData) {
                      BaseListBean<UserTaskList> bean = snap?.data;
                      List<UserTaskList> _taskList = bean.list??[];
                      taskList.clear();
                      taskList.addAll(_taskList);
                      initData = false;
                    }
                    return EasyRefresh(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(child: _itemTask(taskList[index]), onTap: goToActivity,);
                        },
                        itemCount: taskList?.length??0,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 5,);
                        },
                      ),
                      onRefresh: () async {
                        index = 1;
                        getData(index).then((value) {
                          taskList.clear();
                          taskList.addAll(value.list);
                          _easyRefreshController.resetLoadState();
                          setState(() {});
                        });
                      },
                      onLoad: () async {
                        index ++;
                        getData(index).then((value) {
                          taskList.addAll(value.list);
                          _easyRefreshController.finishLoad(success: true, noMore: value.pageNum == value.pages);
                          setState(() {});
                        });
                      },
                      controller: _easyRefreshController,
                    );
                  break;
                default:
                  return new Text('');
                  break;
              }
          }
        ));
  }

  Future<BaseListBean<UserTaskList>> getData(int pageNun) async {
    return await apiService.getUserTaskList(pageNum: pageNun);
  }

  Widget _itemTask(UserTaskList userTaskList) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.network("${userTaskList.logo??Constant.TestImage}", width: 60, height: 60, fit: BoxFit.fill,),),
          Expanded(
            child:Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${userTaskList.taskName}", style: TextStyle(fontSize: 14, color: Colors.black)),
                  SizedBox(height: 10,),
                  Container(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.all(5.0), child: Text("${userTaskList.taskDesc}", style: TextStyle(fontSize: 10, color: AppColors.color_999999), overflow: TextOverflow.ellipsis, maxLines: 3,),), width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: AppColors.color_f8f8f8),),
                  SizedBox(height: 10,),
                  Row(children: [
                    Expanded(child: Text("${userTaskList.merchantName}", style: TextStyle(fontSize: 12, color: Colors.black54),)),
                    Text("￥", style: TextStyle(fontSize: 12, color: Colors.red),),
                    Text("${userTaskList.unitPrice}", style: TextStyle(fontSize: 16, color: Colors.red),)
                  ],),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
