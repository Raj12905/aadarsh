import 'package:base_module/remote/models/base_model.dart';

class UserLoginModelResponse extends BaseModel{
  UserLoginModelResponse({
      super.code,
      super.msg,
      this.data,
      this.baseUrl,
  });

  UserLoginModelResponse.fromJson(dynamic json) {
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    baseUrl = json['base_url'];
  }
  LoginData? data;
  String? baseUrl;
UserLoginModelResponse copyWith({  int? code,

  String? baseUrl,
}) => UserLoginModelResponse(  code: code ?? this.code,
  msg: msg ?? msg,
  data: data ?? data,
  baseUrl: baseUrl ?? this.baseUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['base_url'] = baseUrl;
    return map;
  }

}

class LoginData {
  LoginData({
      this.id, 
      this.name, 
      this.mobile, 
      this.email,
      this.roleType,
      this.roleTypeName, 
      this.cityName, 
      this.stateName, 
      this.address, 
      this.profileImage, 
      this.token, 
      this.status,});

  LoginData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    roleType = json['role_type'];
    email = json['email'];
    roleTypeName = json['role_type_name'];
    cityName = json['city_name'];
    stateName = json['state_name'];
    address = json['address'];
    profileImage = json['profile_image'];
    token = json['token'];
    status = json['status'];
  }
  String? id;
  String? name;
  String? mobile;
  String? roleType;
  String? email;
  String? roleTypeName;
  String? cityName;
  String? stateName;
  String? address;
  String? profileImage;
  String? token;
  String? status;
LoginData copyWith({  String? id,
  String? name,
  String? mobile,
  String? roleType,
  String? email,
  String? roleTypeName,
  String? cityName,
  String? stateName,
  String? address,
  String? profileImage,
  String? token,
  String? status,
}) => LoginData(  id: id ?? this.id,
  name: name ?? this.name,
  mobile: mobile ?? this.mobile,
  roleType: roleType ?? this.roleType,
  email: email ?? this.email,
  roleTypeName: roleTypeName ?? this.roleTypeName,
  cityName: cityName ?? this.cityName,
  stateName: stateName ?? this.stateName,
  address: address ?? this.address,
  profileImage: profileImage ?? this.profileImage,
  token: token ?? this.token,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile'] = mobile;
    map['email'] = email;
    map['role_type'] = roleType;
    map['role_type_name'] = roleTypeName;
    map['city_name'] = cityName;
    map['state_name'] = stateName;
    map['address'] = address;
    map['profile_image'] = profileImage;
    map['token'] = token;
    map['status'] = status;
    return map;
  }

}