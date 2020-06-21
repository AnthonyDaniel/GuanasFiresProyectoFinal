import 'package:firebase_database/firebase_database.dart';

class Fire {
  String key;
  String canton;
  String district;
  int severity;
  String date;
  double lat;
  double long;
  String email;
  String urlImage;
  String urlVideo;
  bool state;

  Fire(this.canton, this.district, this.severity, this.date, this.lat,
      this.long, this.email, this.urlImage, this.urlVideo, this.state);

  Fire.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        canton = snapshot.value["canton"],
        district = snapshot.value["district"],
        severity = snapshot.value["severity"],
        date = snapshot.value["date"],
        lat = snapshot.value["lat"],
        long = snapshot.value["long"],
        email = snapshot.value["email"],
        urlImage = snapshot.value["urlImage"],
        urlVideo = snapshot.value["urlVideo"],
        state = snapshot.value["state"];

  toJson() {
    return {
      "canton": canton,
      "district": district,
      "severity": severity,
      "date": date,
      "lat": lat,
      "long": long,
      "email": email,
      "urlImage": urlImage,
      "urlVideo": urlVideo,
      "state": state,
    };
  }
}
