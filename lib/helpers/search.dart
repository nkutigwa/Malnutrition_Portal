class Search {
  static bool filterSearch(String value, String criteria) {
    return value
        .toString()
        .toLowerCase()
        .trim()
        .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
  }

  static Future<List<String>> search(
      String search, List<String> toFilterList) async {
    await Future.delayed(Duration(seconds: 2));
    if (search == "empty") return [];
    if (search == "error") throw Error();
    if (search.length > 20) throw Error();

    //Initial List of Foods
//    var toFilterList = toFilterList;
    var newList = [];
    var listOfIndex = [];
    print(toFilterList);

    //Filtering Occurs
    try {
      for (int i = 0; i < toFilterList.length; i++) {
        if ((filterSearch(toFilterList[i], search) == true)) {
          newList.add(toFilterList[i]);
          listOfIndex.add(i);
        }
      }
    } catch (e) {
      print(e);
    }
    print(newList);
    return List.generate(newList.length, (int index) {
      return newList[index].toString();
    });
//    newList = [];
  }
}

class School {
  String name;
  School({
    this.id,
    this.region,
    this.district,
    this.name,
  });
  String id;
  String region;
  String district;
  static List<String> schools = [
    "Mapambano Primary School",
    "Madenge Primary School",
    "Miburani Primary School",
    "Pendamoyo Secondary School",
    "Chang'ombe Secondary School",
    "Temeke Primary School",
    "Umoja Primary School",
    "Muungano Primary School",
    "Kawe Ukwamani Secondary School",
    "Kisauke Secondary School",
    "Twiga Secondary School",
    "Malamba mawili Secondary School",
    "Goba Secondary School",
    "Matosa Secondary School",
    "Kiluvya Secondary School",
    "Mbezi inn Secondary School",
    "Msakuzi Primary School",
    "Tungi Secondary School",
    "Kimbiji Secondary School",
    "Pemba mnazi Secondary School",
    "Somangila Secondary School",
    "Vijibweni Secondary School",
    "Sangara Secondary School",
    "Jamhuri Secondary School",
    "Juhudi Secondary School",
    "Ugombolwa Secondary School",
    "Viwege Secondary School",
    "Zawadi Secondary School",
    "Mbezi Primary School",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  ];
  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        region: json["region"],
        district: json["district"],
        name: json["name"],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "district": district,
      };
}
