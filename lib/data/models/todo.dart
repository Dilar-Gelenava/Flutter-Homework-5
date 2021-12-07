class TodoModel {
  int? id;
  String? todo;
  String? description;

  TodoModel({this.id, this.todo, this.description});

  // Todo.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   todo = json['todo'];
  //   description = json['description'];
  // }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['todo'] = todo;
    data['description'] = description;
    return data;
  }
}