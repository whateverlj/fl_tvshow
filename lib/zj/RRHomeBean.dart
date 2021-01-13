



class RRHomeDetailBean {
  String message;
  bool success;
  int code;
  int timestamp;
  DataBean data;

  LoginMsg({this.message, this.success, this.code, this.timestamp, this.data});

  LoginMsg.fromJson(Map<String, dynamic> json) {
    this.message = json['message'];
    this.success = json['success'];
    this.code = json['code'];
    this.timestamp = json['timestamp'];
    this.data = json['data'] != null ? DataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['code'] = this.code;
    data['timestamp'] = this.timestamp;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'LoginMsg{message: $message, success: $success, code: $code, timestamp: $timestamp, data: $data}';
  }


}








public List<BannerInfo> banners;
public List<HotInfo> sections;

public class BannerInfo{
  public String coverUrl;
  public String id;
  public String title;
}

public class HotInfo{
  public List<HotDetailInfo>  tabList;
  public HotDetailInfo singleTab;
  public String type;
}

public  class HotDetailInfo{
  public List<DataListInfo> dataList;
  public String title;
}

public  class DataListInfo{
  public String cover;
  public String id;
  public String score;
  public String seasonNum;
  public String title;
  public String type;
}