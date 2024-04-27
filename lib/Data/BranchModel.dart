class Branch {
  String? key; //random id
  BranchData? branchData;
  Branch(this.key, this.branchData); //(buildingData) give access to the DB
}

class BranchData{
  String? name;
  int? phoneNumber;
  double? latitude;
  double? longitude;
  double? starRating;
  BranchData(this.name,this.phoneNumber,this.latitude,this.longitude,this.starRating);

  BranchData.fromJson(Map<dynamic,dynamic> json) {
    //image = json["image"];
    name = json["name"];
    //place = json["place"];
    phoneNumber = checkInteger(json["phoneNumber"]);
    latitude = checkDouble(json['latitude']);
    longitude = checkDouble(json['longitude']);
    starRating = checkDouble(json['star_rating']);

  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      'latitude' : latitude,
      'longitude' : longitude,
      'star_rating': starRating,

    };
  }
  int? checkInteger(numInt) {
    if (numInt is String) {
      return int.parse(numInt);
    } else if (numInt is double) {
      return int.parse(numInt.toString());
    } else if (numInt is int) {
      return numInt;
    } else {
      return 0;
    }
  }

  double? checkDouble(numDouble) {
    if (numDouble is String) {
      return double.parse(numDouble);
    } else if (numDouble is double) {
      return numDouble;
    } else if (numDouble is int) {
      return double.parse(numDouble.toString());
    } else {
      return 0.0;
    }
  }
}
