class myclass
{

  int? id;
  String? title,note;

  myclass(this.id,this.title,this.note);

  @override
  String toString() {
    return 'myclass{id: $id,title: $title,note: $note}';

  }
  static myclass fromMap(Map m)
  {
    return myclass(m['id'],m['title'],m['note']);
  }
}