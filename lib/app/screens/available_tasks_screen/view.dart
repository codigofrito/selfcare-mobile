import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/shared/utils/moment.dart';
import 'package:tinycolor/tinycolor.dart';
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: Text(
                      "Adicione mais uma tarefa a sua lista:",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      (controller.availableTaskList.length ??
                          controller.perPage),
                      (index) => userTaskRow(index),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userTaskRow(indexTask) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            SizedBox(
              width: Get.width,
              height: Get.width * 0.8,
            ),
            Positioned(
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Hero(
                  tag: 'taskImage$indexTask',
                  createRectTween: (begin, end) {
                    return RectTween(begin: begin, end: end);
                  },
                  child: Container(
                    width: Get.width * 0.8,
                    height: Get.width * 0.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          controller.availableTaskList[indexTask]?.imageUrl ??
                              "",
                        ),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: RawMaterialButton(
                  onPressed: () => Moment.nextDates(DateTime.now(), 5),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: InkWell(
                    onTap: () => this._showAlert(),
                    child: FaIcon(
                      FontAwesomeIcons.clock,
                      color: TinyColor(
                        Theme.of(Get.context).primaryColor,
                      ).darken(30).color,
                    ),
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ),
            ),
          ],
        ),
      );

  void _showAlert() {
    Set<String> schedule = {};
    showDialog(
      context: Get.context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
          insetPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
          title: Text('Seu cu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(7, (index) {
                  final day = describeEnum(Days.values[index]);
                  return DayWeek(
                    label: day,
                    onEnabled: () => schedule.add(day),
                    onDisabled: () => schedule.remove(day),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Flexible(child: TimePicker.hours(onPick: (value) => null)),
                    Expanded(child: SizedBox(width: 16.0)),
                    Flexible(child: TimePicker.minutes(onPick: (value) => null)),
                  ],
                ),
              ),
            ],
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
        onChanged: this.widget.onPick,
        decoration: InputDecoration(
          labelText: '${this.widget.maxAllowedValues == 24 ? 'Hora' : 'Minuto'}',
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
