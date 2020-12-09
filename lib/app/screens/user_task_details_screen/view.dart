import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selfcare/app/data/models/user_task.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/shared/components/custom_app_bar/view.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:selfcare/app/shared/utils/moment.dart';
import 'controller.dart';

class UserTaskDetailsScreen extends GetView<UserTaskDetailsScreenController> {
  final UserTask userTask = Get.arguments['userTask'];
  final int taskKey = Get.arguments['key'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: ListView(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                SizedBox(
                  height: Get.width * .85,
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: TinyColor(Theme.of(context).primaryColor)
                        .brighten(5)
                        .color,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () => Get.back(),
                    ),
                    Text(
                      "Detalhes da tarefa",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Hero(
                    tag: 'userTaskImage${taskKey ?? 0}',
                    child: Container(
                      width: Get.width * 0.7,
                      height: Get.width * 0.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Get.arguments['userTask'].task.imageUrl == null
                              ? AssetImage(
                                  'assets/images/utils/empty_image.png')
                              : NetworkImage(
                                  Get.arguments['userTask'].task.imageUrl,
                                ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Atividade agendada para:",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Toda: ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${DateFormat('EEEE', 'pt_Br').format(Moment.nextDates(DateTime.now(), int.parse(userTask.period)).first).capitalizeFirst}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Horário: ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: '${userTask.schedule.substring(0, 5)}',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.solidEdit,
                          size: 30,
                        ),
                        onPressed: null,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    userTask.task.title,
                    style: TextStyle(
                      color: TinyColor(Theme.of(context).primaryColor)
                          .darken(10)
                          .color,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    userTask.task.description,
                    style: TextStyle(
                      color: TinyColor(Theme.of(context).primaryColor)
                          .darken(30)
                          .color,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: MaterialButton(
                      minWidth: Get.width,
                      height: 50,
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text(
                        "Remover Tarefa",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => showDialog(
                        barrierColor: Colors.black.withOpacity(0.1),
                        context: context,
                        builder: (_) => AlertDialog(
                          content: Text(
                              "Deseja realmente remover essa tarefa da sua lista?"),
                          actions: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: MaterialButton(
                                minWidth: 100,
                                color: Colors.red,
                                textColor: Colors.white,
                                child: Text("Remover"),
                                onPressed: () => controller.deleteTask(
                                    userTask.task.id, taskKey),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: MaterialButton(
                                minWidth: 100,
                                color: Colors.grey,
                                textColor: Colors.white,
                                child: Text("Cancelar"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
