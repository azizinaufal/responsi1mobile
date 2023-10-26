class Assignment {
  int? id;
  String? judulTugas;
  String? deskripsiTugas;
  String? deadlineTugas;
  Assignment(
      {this.id, this.judulTugas, this.deskripsiTugas, this.deadlineTugas});
  factory Assignment.fromJson(Map<String, dynamic> obj) {
    return Assignment(
        id: obj['id'],
        judulTugas: obj['title'],
        deskripsiTugas: obj['description'],
        deadlineTugas: obj['deadline']);
  }
}
