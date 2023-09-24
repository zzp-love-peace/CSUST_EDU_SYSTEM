class OldCourseModel {
  late int id;
  late String term;
  late int weekNum;
  late String content;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'term': term,
      'weekNum': weekNum,
      'content': content,
    };
    return map;
  }

  OldCourseModel(this.term, this.weekNum, this.content, {int? id}) {
    this.id = id ?? -1;
  }

  OldCourseModel.fromMap(Map map) {
    id = map['id'];
    term = map['term'];
    weekNum = map['weekNum'];
    content = map['content'];
  }
}