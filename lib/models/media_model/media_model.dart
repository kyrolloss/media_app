class MediaModel{
  late int id;
  late String url;
  late String title;
  late String type;
  String? thumbnail;

  MediaModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    url = json["path"];
    title = json["title"];
    type = json["type"];
    thumbnail = json["thumbnail"];
  }
}