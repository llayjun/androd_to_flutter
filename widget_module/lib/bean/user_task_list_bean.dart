class UserTaskList {
  int _id;
  int _merchantId;
  String _merchantName;
  dynamic _logo;
  String _taskName;
  String _taskDesc;
  dynamic _taskAddress;
  double _unitPrice;

  int get id => _id;

  int get merchantId => _merchantId;

  String get merchantName => _merchantName;

  dynamic get logo => _logo;

  String get taskName => _taskName;

  String get taskDesc => _taskDesc;

  dynamic get taskAddress => _taskAddress;

  double get unitPrice => _unitPrice;

  UserTaskList(
      {int id,
      int merchantId,
      String merchantName,
      dynamic logo,
      String taskName,
      String taskDesc,
      dynamic taskAddress,
      double unitPrice}) {
    _id = id;
    _merchantId = merchantId;
    _merchantName = merchantName;
    _logo = logo;
    _taskName = taskName;
    _taskDesc = taskDesc;
    _taskAddress = taskAddress;
    _unitPrice = unitPrice;
  }

  UserTaskList.fromJson(dynamic json) {
    _id = json["id"];
    _merchantId = json["merchantId"];
    _merchantName = json["merchantName"];
    _logo = json["logo"];
    _taskName = json["taskName"];
    _taskDesc = json["taskDesc"];
    _taskAddress = json["taskAddress"];
    _unitPrice = json["unitPrice"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["merchantId"] = _merchantId;
    map["merchantName"] = _merchantName;
    map["logo"] = _logo;
    map["taskName"] = _taskName;
    map["taskDesc"] = _taskDesc;
    map["taskAddress"] = _taskAddress;
    map["unitPrice"] = _unitPrice;
    return map;
  }
}
