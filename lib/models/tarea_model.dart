//
//    Modelo generado de las tareas para ocupara con las vistas
//     final tarea = tareaFromMap(jsonString);

import 'dart:convert';

Tarea tareaFromMap(String str) => Tarea.fromMap(json.decode(str));

String tareaToMap(Tarea data) => json.encode(data.toMap());

class Tarea {
  Tarea({
    this.title,
    this.isCompleted,
    this.dueDate,
    this.comments,
    this.description,
    this.tags,
    this.token,
    this.id,
  });

  String? title;
  int? isCompleted;
  dynamic dueDate;
  dynamic comments;
  String? description;
  dynamic tags;
  dynamic token;

  int? id;

  factory Tarea.fromMap(Map<String, dynamic> json) => Tarea(
        title: json["title"],
        isCompleted: json["is_completed"],
        dueDate: json["due_date"],
        comments: json["comments"],
        description: json["description"],
        tags: json["tags"],
        token: json["token"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "is_completed": isCompleted,
        "due_date": dueDate,
        "comments": comments,
        "description": description,
        "tags": tags,
        "token": token,
        "id": id,
      };
}
