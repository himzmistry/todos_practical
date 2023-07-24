import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../model/todo_data_model.dart';
import '../model/todo_model.dart';
import '../network/api_network.dart';
import '../network/api_sheet.dart';

class HomeScreenController extends GetxController {
  List<TodoDataModel> todoList = <TodoDataModel>[];
  RxList<TodoModel> finalTodos = <TodoModel>[].obs;
  Set<int> uniqueUserId = {};
  RxBool loading = false.obs;

  fetchData() async {
    try {
      loading.value = true;
      dio.Response response = await ApiNetwork().getRequest(ApiSheet.todos);
      todoList.clear();
      finalTodos.clear();
      log('response.data ${response.data}');
      todoList = (response.data as List)
          .map((data) => TodoDataModel.fromJson(data))
          .toList();

      for (int i = 0; i < todoList.length; i++) {
        TodoDataModel element = todoList[i];
        if (uniqueUserId.contains(element.userId)) {
          for (int j = 0; j < finalTodos.length; j++) {
            if (element.userId == finalTodos[j].userId) {
              if (element.completed ?? false) {
                finalTodos[j].completedList.add(element);
              } else {
                finalTodos[j].inCompletedList.add(element);
              }
            }
          }
        } else {
          uniqueUserId.add(element.userId ?? 0);
          TodoModel todo = TodoModel(
              userId: element.userId ?? 0,
              inCompletedList: [],
              completedList: []);
          finalTodos.add(todo);
        }
      }
    } catch (e) {
      log('fetchData: $e');
    } finally {
      loading.value = false;
    }
  }
}
