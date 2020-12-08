import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selfcare/app/shared/components/custom_app_bar/view.dart';
import 'package:tinycolor/tinycolor.dart';

class UserTaskDetailsPage extends GetView<UserTaskDetailsPage> {
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
                    tag: 'userTaskImage${Get.arguments['key']}',
                    child: Container(
                      width: Get.width * 0.7,
                      height: Get.width * 0.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Get.arguments['task'].task.imageUrl == null
                              ? AssetImage(
                                  'assets/images/utils/empty_image.png')
                              : NetworkImage(
                                  Get.arguments['task'].task.imageUrl,
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Get.arguments['task'].task.title,
                    style: TextStyle(
                      color: TinyColor(Theme.of(context).primaryColor)
                          .darken(30)
                          .color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    Get.arguments['task'].task.description,
                    style: TextStyle(
                      color: TinyColor(Theme.of(context).primaryColor)
                          .darken(30)
                          .color,
                      fontSize: 20,
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Dias: ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Sexta-feira',
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
                          text:
                              '${DateFormat('HH:mm').format(Get.arguments['task'].schedule)}',
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
            ),
          ],
        ),
      ),
    );
  }
}
