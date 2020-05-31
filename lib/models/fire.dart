import 'package:firebase_database/firebase_database.dart';

class Fire {
  String key;
  String canton;
  String district;
  String severity;
  String date;
  String fireId;

  Fire(this.canton, this.district, this.date, this.severity, this.fireId);

  Fire.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        canton = snapshot.value["canton"],
        district = snapshot.value["ditrict"],
        severity = snapshot.value["severity"],
        date = snapshot.value["date"],
        fireId = snapshot.value["fireId"];

  toJson() {
    return {
      "canton": canton,
      "district": district,
      "severity": severity,
      "date": date,
      "fireId": fireId
    };
  }
}