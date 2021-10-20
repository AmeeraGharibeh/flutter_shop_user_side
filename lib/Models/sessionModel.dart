
class sessionModel {

  String sessionId;
  String userId;
  String lastModification;
  sessionModel({this.sessionId, this.userId, this.lastModification});

  sessionModel.fromMap(Map<String, dynamic> json){
    sessionId = json['sessionId'];
    userId = json['userId'];
    lastModification = json['lastModification'];
  }
}