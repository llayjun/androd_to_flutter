class BaseListBean<T> {
  List<T> list;
  int pageNum;
  int pageSize;
  int total;
  int pages;

  BaseListBean(
      {this.list, this.pageNum, this.pageSize, this.total, this.pages});

  factory BaseListBean.fromJson(Map<String, dynamic> json) {
    return BaseListBean(
      list: json['list'],
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      total: json['total'],
      pages: json['pages'],
    );
  }

  // baseListBean.datas.map((m) => new ArticleItemBean.fromJson(m)).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list'] = this.list;
    data['pageNum'] = this.pageNum;
    data['pageSize'] = this.pageSize;
    data['total'] = this.total;
    data['pages'] = this.pages;
    return data;
  }
}
