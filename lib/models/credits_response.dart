// To parse this JSON data, do
// final creditsResponse = creditsResponseFromMap(jsonString);

import 'dart:convert';

class CreditsResponse {
  CreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;
  
  factory CreditsResponse.fromJson(String str) => CreditsResponse.fromMap(json.decode(str));
  //String toJson() => json.encode(toMap());
  factory CreditsResponse.fromMap(Map<String, dynamic> json) => CreditsResponse(
      id: json["id"],
      cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
      crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
  );
  /* Map<String, dynamic> toMap() => {
      "id": id,
      "cast": List<dynamic>.from(cast.map((x) => x.toMap())),
      "crew": List<dynamic>.from(crew.map((x) => x.toMap())),
  }; */
}

class Cast {
    Cast({
      required this.adult,
      this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      required this.creditId,
      this.order,
      this.department,
      this.job,
    });

    bool adult;
    int? gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String? department;
    String? job;

    get fullProfilePath {
      if(this.profilePath != null) {
        return 'https://image.tmdb.org/t/p/w500${this.profilePath}';
      }else if(this.profilePath == null || this.profilePath!.isEmpty) {
        return 'https://ualr.edu/studentaffairs/files/2020/01/blank-picture-holder.png';
      }
    }

    factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

    //String toJson() => json.encode(toMap());

    factory Cast.fromMap(Map<String, dynamic> json) => Cast(
      adult: json["adult"],
      gender: json["gender"],
      id: json["id"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: json["popularity"].toDouble(),
      profilePath: json["profile_path"] == null ? null : json["profile_path"],
      castId: json["cast_id"] == null ? null : json["cast_id"],
      character: json["character"] == null ? null : json["character"],
      creditId: json["credit_id"],
      order: json["order"] == null ? null : json["order"],
      department: json["department"] == null ? null : json["department"],
      job: json["job"] == null ? null : json["job"],
    );

    /* Map<String, dynamic> toMap() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": departmentValues.reverse[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath == null ? null : profilePath,
        "cast_id": castId == null ? null : castId,
        "character": character == null ? null : character,
        "credit_id": creditId,
        "order": order == null ? null : order,
        "department": department == null ? null : departmentValues.reverse[department],
        "job": job == null ? null : job,
    }; */
}



