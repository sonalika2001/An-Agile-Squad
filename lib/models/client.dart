class Client {
  String uid;
  String name;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;

  Client({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
  });

  Map toMap(Client client) {
    var data = Map<String, dynamic>();
    data['uid'] = client.uid;
    data['name'] = client.name;
    data['email'] = client.email;
    data['username'] = client.username;
    data["status"] = client.status;
    data["state"] = client.state;
    data["profile_photo"] = client.profilePhoto;
    return data;
  }

  //static function which takes a map and creates a Client object
  Client.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.status = mapData['status'];
    this.state = mapData['state'];
    this.profilePhoto = mapData['profile_photo'];
  }
}
