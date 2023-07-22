class NoteModel {
  int? notesId;
  String? title;
  String? content;
  String? noteImage;
  int? userid;

  NoteModel(
      {this.notesId, this.title, this.content, this.noteImage, this.userid});

  NoteModel.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    title = json['title'];
    content = json['content'];
    noteImage = json['note_image'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_id'] = this.notesId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['note_image'] = this.noteImage;
    data['userid'] = this.userid;
    return data;
  }
}