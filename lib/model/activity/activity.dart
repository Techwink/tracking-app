class Activity {
  Activity({
        this.userId,
        this.userStatusType,
        this.securityAssignmentId,
        this.isAssignmentStarted,
        this.authToken,
        this.userRoleId,
        this.timestamp,
        this.deviceId,
        this.distance,
        this.latitude,
        this.longitude,
        this.accuracy,
        this.floorId
  });

  final String? userId;
  final String? userStatusType;
  final String? securityAssignmentId;
  final String? isAssignmentStarted;
  final String? authToken;
  final String? userRoleId;
  final String? timestamp;
  final String? deviceId;
  final int? distance;
  final String? latitude;
  final String? longitude;
  final String? accuracy;
  final int? floorId;


  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    userId : json["user_id"],
    userStatusType : json["user_status_type"],
    securityAssignmentId : json["security_assignment_id"],
    isAssignmentStarted : json["is_assignment_started"],
    authToken : json["auth_token"],
    userRoleId : json["user_role_id"],
    timestamp : json["timestamp"],
    deviceId : json["device_id"],
    distance : json["distance"],
    latitude : json["latitude"],
    longitude : json["longitude"],
    accuracy : json["accuracy"],
    floorId : json["floor_id"],
  );

  Map<String, dynamic> toJson() => {
    'user_id' : userId,
    'user_status_type' : userStatusType,
    'security_assignment_id' : securityAssignmentId,
    'is_assignment_started' : isAssignmentStarted,
    'auth_token' : authToken,
    'user_role_id' : userRoleId,
    'timestamp' : timestamp,
    'device_id' : deviceId,
    'distance' : distance,
    'latitude' : latitude,
    'longitude' : longitude,
    'accuracy' : accuracy,
    'floor_id' : floorId,
  };

  Map<String,dynamic> toMap() {
    return{
      'user_id' : userId,
      'user_status_type' : userStatusType,
      'security_assignment_id' : securityAssignmentId,
      'is_assignment_started' : isAssignmentStarted,
      'auth_token' : authToken,
      'user_role_id' : userRoleId,
      'timestamp' : timestamp,
      'device_id' : deviceId,
      'distance' : distance,
      'latitude' : latitude,
      'longitude' : longitude,
      'accuracy' : accuracy,
      'floor_id' : floorId,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      userId : map["user_id"],
      userStatusType : map["user_status_type"],
      securityAssignmentId : map["security_assignment_id"],
      isAssignmentStarted : map["is_assignment_started"],
      authToken : map["auth_token"],
      userRoleId : map["user_role_id"],
      timestamp : map["timestamp"],
      deviceId : map["device_id"],
      distance : map["distance"],
      latitude : map["latitude"],
      longitude : map["longitude"],
      accuracy : map["accuracy"],
      floorId : map["floor_id"],
    );
  }
}