class ApprovalResponse {
  ApprovalResponse({
      this.code,
      this.msg,
      this.count,
      this.data,});

  ApprovalResponse.fromJson(dynamic json) {
    code = json['code'];
    msg = json['msg'];
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ApprovalData.fromJson(v));
      });
    }
  }
  int? code;
  String? msg;
  int? count;
  List<ApprovalData>? data;
ApprovalResponse copyWith({  int? code,
  String? msg,
  int? count,
  List<ApprovalData>? data,
}) => ApprovalResponse(  code: code ?? this.code,
  msg: msg ?? this.msg,
  count: count ?? this.count,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['msg'] = msg;
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ApprovalData {
  ApprovalData({
      this.id,
      this.requestId,
      this.requestDid,
      this.requestReceivedDid,
      this.forwardDid,
      this.supId,
      this.leaveStatus,
      this.materialStatus,
      this.materialIssue,
      this.requestDateTime,
      this.dueDate,
      this.titleId,
      this.subject,
      this.remarksTextarea,
      this.status,
      this.remarks1,
      this.remarks2,
      this.remarks3,
      this.remarks4,
      this.remarks5,
      this.attachment1,
      this.attachment2,
      this.attachment3,
      this.attachment4,
      this.attachment5,
      this.createdAt,
      this.updatedAt,});

  ApprovalData.fromJson(dynamic json) {
    id = json['id'];
    requestId = json['request_id'];
    requestDid = json['request_did'];
    requestReceivedDid = json['request_received_did'];
    forwardDid = json['forward_did'];
    supId = json['sup_id'];
    leaveStatus = json['leave_status'];
    materialStatus = json['material_status'];
    materialIssue = json['material_issue'];
    requestDateTime = json['request_date_time'];
    dueDate = json['due_date'];
    titleId = json['title_id'];
    subject = json['subject'];
    remarksTextarea = json['remarks_textarea'];
    status = json['status'];
    remarks1 = json['remarks1'];
    remarks2 = json['remarks2'];
    remarks3 = json['remarks3'];
    remarks4 = json['remarks4'];
    remarks5 = json['remarks5'];
    attachment1 = json['attachment1'];
    attachment2 = json['attachment2'];
    attachment3 = json['attachment3'];
    attachment4 = json['attachment4'];
    attachment5 = json['attachment5'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? requestId;
  String? requestDid;
  String? requestReceivedDid;
  String? forwardDid;
  String? supId;
  String? leaveStatus;
  String? materialStatus;
  String? materialIssue;
  String? requestDateTime;
  String? dueDate;
  String? titleId;
  String? subject;
  String? remarksTextarea;
  String? status;
  dynamic remarks1;
  dynamic remarks2;
  dynamic remarks3;
  dynamic remarks4;
  dynamic remarks5;
  dynamic attachment1;
  dynamic attachment2;
  dynamic attachment3;
  dynamic attachment4;
  dynamic attachment5;
  String? createdAt;
  String? updatedAt;
ApprovalData copyWith({  String? id,
  String? requestId,
  String? requestDid,
  String? requestReceivedDid,
  String? forwardDid,
  String? supId,
  String? leaveStatus,
  String? materialStatus,
  String? materialIssue,
  String? requestDateTime,
  String? dueDate,
  String? titleId,
  String? subject,
  String? remarksTextarea,
  String? status,
  dynamic remarks1,
  dynamic remarks2,
  dynamic remarks3,
  dynamic remarks4,
  dynamic remarks5,
  dynamic attachment1,
  dynamic attachment2,
  dynamic attachment3,
  dynamic attachment4,
  dynamic attachment5,
  String? createdAt,
  String? updatedAt,
}) => ApprovalData(  id: id ?? this.id,
  requestId: requestId ?? this.requestId,
  requestDid: requestDid ?? this.requestDid,
  requestReceivedDid: requestReceivedDid ?? this.requestReceivedDid,
  forwardDid: forwardDid ?? this.forwardDid,
  supId: supId ?? this.supId,
  leaveStatus: leaveStatus ?? this.leaveStatus,
  materialStatus: materialStatus ?? this.materialStatus,
  materialIssue: materialIssue ?? this.materialIssue,
  requestDateTime: requestDateTime ?? this.requestDateTime,
  dueDate: dueDate ?? this.dueDate,
  titleId: titleId ?? this.titleId,
  subject: subject ?? this.subject,
  remarksTextarea: remarksTextarea ?? this.remarksTextarea,
  status: status ?? this.status,
  remarks1: remarks1 ?? this.remarks1,
  remarks2: remarks2 ?? this.remarks2,
  remarks3: remarks3 ?? this.remarks3,
  remarks4: remarks4 ?? this.remarks4,
  remarks5: remarks5 ?? this.remarks5,
  attachment1: attachment1 ?? this.attachment1,
  attachment2: attachment2 ?? this.attachment2,
  attachment3: attachment3 ?? this.attachment3,
  attachment4: attachment4 ?? this.attachment4,
  attachment5: attachment5 ?? this.attachment5,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['request_id'] = requestId;
    map['request_did'] = requestDid;
    map['request_received_did'] = requestReceivedDid;
    map['forward_did'] = forwardDid;
    map['sup_id'] = supId;
    map['leave_status'] = leaveStatus;
    map['material_status'] = materialStatus;
    map['material_issue'] = materialIssue;
    map['request_date_time'] = requestDateTime;
    map['due_date'] = dueDate;
    map['title_id'] = titleId;
    map['subject'] = subject;
    map['remarks_textarea'] = remarksTextarea;
    map['status'] = status;
    map['remarks1'] = remarks1;
    map['remarks2'] = remarks2;
    map['remarks3'] = remarks3;
    map['remarks4'] = remarks4;
    map['remarks5'] = remarks5;
    map['attachment1'] = attachment1;
    map['attachment2'] = attachment2;
    map['attachment3'] = attachment3;
    map['attachment4'] = attachment4;
    map['attachment5'] = attachment5;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}