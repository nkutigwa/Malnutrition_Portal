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
    "Mapambano",
    'Madenge Primary School',
    'St. Joseph Primary School',
    'Mount Everest Primary School',
    'Feza Boys',
    'Ali Muntazr Primary School',
    'Zucha Secondary School',
    "School",
    "Marian",
    "Ilboru (Disabled)",
    "Temeke boys",
    'St.Marys',
    'Heaven of Peace Academy'
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
