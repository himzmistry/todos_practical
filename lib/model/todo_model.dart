import 'todo_data_model.dart';

class TodoModel {
  int userId;
  List<TodoDataModel> completedList;
  List<TodoDataModel> inCompletedList;

  TodoModel({required this.userId,required  this.completedList,required  this.inCompletedList});
}
