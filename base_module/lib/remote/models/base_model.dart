class BaseModel {
  BaseModel({this.code, this.status, this.msg});
  int? code;
  bool? status;
  String? msg;

  BaseModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    msg = json['msg'];
  }
}
