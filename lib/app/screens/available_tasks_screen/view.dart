import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/shared/components/page_header/view.dart';
import 'package:flutter/material.dart';
import 'package:selfcare/app/shared/components/custom_app_bar/view.dart';

import 'controller.dart';

class AvailableTasksScreen extends GetView<AvailableTasksScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () => controller.refresh(),
            child: ListView(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[
                    PageHeader(),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () => Get.back(),
                        ),
                        Text(
                          "Agendar nova tarefa",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          (controller.availableTaskList.length ??
                              controller.perPage),
                          (index) => _taskRow(index),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _taskRow(indexTask) => Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          SizedBox(
            width: Get.width,
            height: 290,
          ),
          Positioned(
            top: 20,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Container(
                width: Get.width * .9,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: 'taskImage$indexTask',
                      createRectTween: (begin, end) {
                        return RectTween(begin: begin, end: end);
                      },
                      child: Container(
                        width: Get.width * 0.3,
                        height: Get.width * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              controller
                                      .availableTaskList[indexTask].imageUrl ??
                                  "",
                            ),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: Get.width * 0.55,
                      height: Get.width * 0.5,
                      //color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${controller.availableTaskList[indexTask].title}',
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(Get.context).primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${controller.availableTaskList[indexTask].description}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 6,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Positioned(
            bottom: 0,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: MaterialButton(
                height: 50,
                color: Theme.of(Get.context).primaryColor,
                textColor: Colors.white,
                child: SizedBox(
                  width: 100,
                  child: FittedBox(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.calendarAlt,
                          size: 15,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Agendar")
                      ],
                    ),
                  ),
                ),
                onPressed: () => this._showAlert(indexTask),
              ),
            ),
          ),
        ],
      );

  void _showAlert(dynamic taskId) {
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
              'Agendar atividade',
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
                onPressed: () => controller.storeNewUserTask(
                  taskId,
                  schedule.first
                      .toString()
                      .replaceFirst('{', '')
                      .replaceFirst('}', ''),
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

enum Days { DOM, SEG, TER, QUA, QUI, SEX, SAB }

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
