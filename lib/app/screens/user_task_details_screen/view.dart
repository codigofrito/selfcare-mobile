import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selfcare/app/data/models/user_task_model.dart';
import 'package:selfcare/app/shared/components/custom_app_bar/view.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:selfcare/app/shared/utils/moment.dart';
import 'package:selfcare/app/shared/components/page_header/view.dart';
import 'package:flutter/foundation.dart';
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
                PageHeader(),
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
                                      '${userTask.period.toList().map((value) => Days.values[value - 1].toString().split('.').last.capitalizeFirst).join(', ')}',
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
                        onPressed: () => this._showAlert(userTask.task),
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
                            "Deseja realmente remover essa tarefa da sua lista?",
                          ),
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
                                onPressed: () => controller.deleteUserTask(
                                    userTask, taskKey),
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

  void _showAlert(dynamic task) {
    Set<int> schedule = {};
    String scheduleHour = DateTime.now().hour.toString().padLeft(2, '0');
    String scheduleMinute = DateTime.now().minute.toString().padLeft(2, '0');

    showDialog(
      context: Get.context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 24),
            insetPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
            title: Text(
              'Editar atividade',
              style: TextStyle(color: Get.theme.primaryColor),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(Get.context).pop(),
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Get.theme.errorColor,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () => controller.updateUserTask(
                  task,
                  schedule,
                  '$scheduleHour:$scheduleMinute',
                ),
                color: Get.theme.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  'Confirmar',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(7, (index) {
                      final day = Days.values[index].index + 1;
                      return DayWeek(
                        label: describeEnum(Days.values[index]),
                        onEnabled: () => schedule.add(day),
                        onDisabled: () => schedule.remove(day),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: TimePicker.hours(
                            onPick: (value) => scheduleHour = value),
                      ),
                      Flexible(child: SizedBox(width: 0.0)),
                      Flexible(
                        child: TimePicker.minutes(
                            onPick: (value) => scheduleMinute = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


enum Days { SEG, TER, QUA, QUI, SEX, SAB, DOM }

class DayWeek extends StatefulWidget {
  final String label;
  final VoidCallback onEnabled;
  final VoidCallback onDisabled;
  final bool isEnabled;

  const DayWeek({
    Key key,
    @required this.label,
    @required this.onEnabled,
    @required this.onDisabled,
    this.isEnabled = false,
  })  : assert(label != null),
        assert(onEnabled != null),
        assert(onDisabled != null),
        assert(isEnabled != null),
        super(key: key);

  @override
  _DayWeekState createState() => _DayWeekState();
}

class _DayWeekState extends State<DayWeek> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Color> backgroundAnimation;
  Animation<Color> textAnimation;

  @override
  void initState() {
    super.initState();
    this.animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    this.animationController.addListener(() => setState(() {}));
    this.animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) this.widget.onEnabled();
      if (status == AnimationStatus.reverse) this.widget.onDisabled();
    });

    this.backgroundAnimation = ColorTween(
      begin: Colors.white,
      end: Get.theme.primaryColor,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
        parent: this.animationController,
      ),
    );

    this.textAnimation = ColorTween(
      begin: Get.theme.primaryColor,
      end: Colors.white,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
        parent: this.animationController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: this.backgroundAnimation.value,
          border: Border.all(color: this.textAnimation.value),
        ),
        child: Text(
          this.widget.label,
          style: TextStyle(color: this.textAnimation.value),
        ),
      ),
      onTap: () {
        if (this.animationController.status == AnimationStatus.reverse ||
            this.animationController.status == AnimationStatus.dismissed) {
          this.animationController.forward();
          return;
        }

        this.animationController.reverse();
      },
    );
  }

  @override
  void dispose() {
    this.animationController.dispose();
    super.dispose();
  }
}

class TimePicker extends StatefulWidget {
  final int maxAllowedValues;
  final void Function(String value) onPick;

  const TimePicker.hours({Key key, @required this.onPick})
      : assert(onPick != null),
        this.maxAllowedValues = 24,
        super(key: key);

  const TimePicker.minutes({Key key, @required this.onPick})
      : assert(onPick != null),
        this.maxAllowedValues = 60,
        super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
        onChanged: this.widget.onPick,
        value: (this.widget.maxAllowedValues - 1).toString(),
        decoration: InputDecoration(
          labelText:
              '${this.widget.maxAllowedValues == 24 ? 'Hora' : 'Minuto'}',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 21,
          ),
          border: InputBorder.none,
        ),
        items: List.generate(
          this.widget.maxAllowedValues,
          (index) {
            final time = index.toString();
            final formattedTime = time.length < 2 ? '0$time' : time;

            return DropdownMenuItem(
              child: Text(formattedTime),
              value: formattedTime,
            );
          },
        ));
  }
}
