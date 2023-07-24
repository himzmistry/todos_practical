import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../constants/app_colors.dart';
import '../controllers/home_screen_controller.dart';
import '../model/todo_data_model.dart';
import '../utility/custom_widgets.dart';
import '../utility/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController controller = Get.put(HomeScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    await controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Obx(() => mainBody())));
  }

  mainBody() => controller.loading.value
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : controller.finalTodos.isEmpty
          ? const Center(
              child: Text('No data found'),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  // height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.textColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      verticalBox(),
                      userIdText(index),
                      verticalBox(),
                      Row(
                        children: [
                          horizontalBox(width: 10.0),
                          taskStatusList("Completed",
                              controller.finalTodos[index].completedList),
                          Spacer(),
                          taskStatusList("Incomplete",
                              controller.finalTodos[index].inCompletedList),
                          horizontalBox(width: 10.0),
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return verticalBox(height: 10.0);
              },
              itemCount: controller.finalTodos.length);

  taskStatusList(
    String title,
    List<TodoDataModel> taskList,
  ) =>
      Column(
        children: [
          Text('$title Tasks: ${taskList.length}'),
          verticalBox(),
          SizedBox(
            height: 100.0,
            width: 120.0,
            child: taskList.isEmpty
                ? const Text("No data found")
                : ListView.separated(
                    itemBuilder: (context, taskIndex) {
                     return Text(
                       "${taskIndex.toString()}  ${taskList[taskIndex].title ?? "No title"}",
                        style: Utils.normalTextStyle(size: 11.0),
                      );
                    },
                    separatorBuilder: (context, taskIndex) {
                      return verticalBox();
                    },
                    itemCount: taskList.length),
          )
        ],
      );

  userIdText(index) => Text(
        "UserID: ${controller.finalTodos[index].userId}",
        style: Utils.normalTextStyle(),
      );
}
