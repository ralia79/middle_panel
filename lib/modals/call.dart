class Call {
  String callerName;
  String callerId;
  String callerPic;
  String reciverName;
  String reciverId;
  String reciverPic;

  String chanelId;
  bool hasDialled;

  Call({
    required this.callerName,
    required this.callerId,
    required this.callerPic,
    required this.reciverName,
    required this.reciverId,
    required this.reciverPic,
    required this.chanelId,
    required this.hasDialled,
  });

  // to map
  Map<String, dynamic> toMap(Call call) {
    Map<String, dynamic> callMap = Map();
    callMap["caller_id"] = call.callerId;
    callMap["caller_name"] = call.callerName;
    callMap["caller_pic"] = call.callerPic;
    callMap["receiver_id"] = call.reciverId;
    callMap["receiver_name"] = call.reciverName;
    callMap["receiver_pic"] = call.reciverPic;
    callMap["channel_id"] = call.chanelId;
    callMap["has_dialled"] = call.hasDialled;
    return callMap;
  }

  fromMap(Map callMap) {
    this.callerId = callMap["caller_id"];
    this.callerName = callMap["caller_name"];
    this.callerPic = callMap["caller_pic"];
    this.reciverId = callMap["receiver_id"];
    this.reciverName = callMap["receiver_name"];
    this.reciverPic = callMap["receiver_pic"];
    this.chanelId = callMap["channel_id"];
    this.hasDialled = callMap["has_dialled"];
  }
}
