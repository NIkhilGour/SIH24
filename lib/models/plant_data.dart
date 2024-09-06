class Data {
  Collections? cCollections;

  Data({this.cCollections});

  Data.fromJson(Map<String, dynamic> json) {
    cCollections = json['_collections_'] != null
        ? Collections.fromJson(json['_collections_'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cCollections != null) {
      data['_collections_'] = cCollections!.toJson();
    }
    return data;
  }
}

class Collections {
  List<HerbalPlants>? herbalPlants;

  Collections({this.herbalPlants});

  Collections.fromJson(Map<String, dynamic> json) {
    if (json['herbalPlants'] != null) {
      herbalPlants = <HerbalPlants>[];
      json['herbalPlants'].forEach((v) {
        herbalPlants!.add(HerbalPlants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (herbalPlants != null) {
      data['herbalPlants'] = herbalPlants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HerbalPlants {
  String? hindiName;
  String? englishName;
  String? botanicalName;
  List<String>? uses;
  List<String>? imageUrls;
  String? description;
  String? type;
  List<String>? soilType;
  String? sunlight;
  String? wateringFrequency;
  String? season;
  String? region;
  List<String>? tags;

  HerbalPlants(
      {this.hindiName,
      this.englishName,
      this.botanicalName,
      this.uses,
      this.imageUrls,
      this.description,
      this.type,
      this.soilType,
      this.sunlight,
      this.wateringFrequency,
      this.season,
      this.region,
      this.tags});

  HerbalPlants.fromJson(Map<String, dynamic> json) {
    hindiName = json['hindiName'];
    englishName = json['englishName'];
    botanicalName = json['botanicalName'];
    uses = json['uses'].cast<String>();
    imageUrls = json['imageUrls'].cast<String>();
    description = json['description'];
    type = json['type'];
    soilType = json['soilType'].cast<String>();
    sunlight = json['sunlight'];
    wateringFrequency = json['wateringFrequency'];
    season = json['season'];
    region = json['region'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hindiName'] = hindiName;
    data['englishName'] = englishName;
    data['botanicalName'] = botanicalName;
    data['uses'] = uses;
    data['imageUrls'] = imageUrls;
    data['description'] = description;
    data['type'] = type;
    data['soilType'] = soilType;
    data['sunlight'] = sunlight;
    data['wateringFrequency'] = wateringFrequency;
    data['season'] = season;
    data['region'] = region;
    data['tags'] = tags;
    return data;
  }
}
