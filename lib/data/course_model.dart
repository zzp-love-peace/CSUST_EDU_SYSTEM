class CourseModel {
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

  CourseModel(this.term, this.weekNum, this.content, {int? id}) {
    this.id = id ?? -1;
  }

  CourseModel.fromMap(Map map) {
    id = map['id'];
    term = map['term'];
    weekNum = map['weekNum'];
    content = map['content'];
  }
}