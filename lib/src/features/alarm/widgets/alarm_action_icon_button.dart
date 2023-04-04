import 'dart:math';

import 'package:alarm_clock/src/core/app_colors.dart';
import 'package:alarm_clock/src/core/app_style.dart';
import 'package:alarm_clock/src/core/widgets/action_icon_button_widget.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm_bloc.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/alarm_type.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class AlarmActionIconButton extends StatefulWidget {
  const AlarmActionIconButton({Key? key}) : super(key: key);

  @override
  State<AlarmActionIconButton> createState() => _AlarmActionIconButtonState();
}

class _AlarmActionIconButtonState extends State<AlarmActionIconButton> {
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController();
    _minuteController = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActionIconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            String timeOfDay = 'PM';
            AlarmType type = AlarmType.everyday;
            List<String> days = [];
            return Container(
              padding: const EdgeInsets.all(16),
              height: 400,
              color: AppColors.mainWhite,
              child: StatefulBuilder(
                builder: (context, setter) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const _BottomSheetTextWidget(text: 'Time'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 40,
                          child: _ListWheelScrollView(
                            controller: _hourController,
                            countItems: 12,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          width: 40,
                          child: _ListWheelScrollView(
                            controller: _minuteController,
                            countItems: 60,
                          ),
                        ),
                      ],
                    ),
                    const _BottomSheetTextWidget(text: 'Time of day'),
                    StatefulBuilder(
                      builder: (context, set) {
                        return DropdownButton<String>(
                          value: timeOfDay,
                          items: const [
                            DropdownMenuItem<String>(
                              value: 'PM',
                              child: Text('PM'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'AM',
                              child: Text('AM'),
                            ),
                          ],
                          onChanged: (value) {
                            timeOfDay = value!;
                            set(() {});
                          },
                        );
                      },
                    ),
                    const _BottomSheetTextWidget(text: 'Type'),
                    StatefulBuilder(
                      builder: (context, set) {
                        return DropdownButton<AlarmType>(
                          value: type,
                          items: const [
                            DropdownMenuItem<AlarmType>(
                              value: AlarmType.everyday,
                              child: _BottomSheetTextWidget(text: 'Everyday'),
                            ),
                            DropdownMenuItem<AlarmType>(
                              value: AlarmType.selectedDays,
                              child: _BottomSheetTextWidget(text: 'Days'),
                            ),
                          ],
                          onChanged: (value) {
                            type = value!;
                            set(() {});
                            setter(() {});
                          },
                        );
                      },
                    ),
                    if (type == AlarmType.selectedDays)
                      TextButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return MultiSelectDialog<String>(
                                initialValue: days,
                                items: [
                                  MultiSelectItem<String>(
                                    'Sun',
                                    'Sun',
                                  ),
                                  MultiSelectItem<String>(
                                    'Mon',
                                    'Mon',
                                  ),
                                  MultiSelectItem<String>(
                                    'Tue',
                                    'Tue',
                                  ),
                                  MultiSelectItem<String>(
                                    'Wed',
                                    'Wed',
                                  ),
                                  MultiSelectItem<String>(
                                    'Thu',
                                    'Thu',
                                  ),
                                  MultiSelectItem<String>(
                                    'Fri',
                                    'Fri',
                                  ),
                                  MultiSelectItem<String>(
                                    'Sat',
                                    'Sat',
                                  ),
                                ],
                                onConfirm: (value) {
                                  days = value;
                                },
                              );
                            },
                          );
                        },
                        child: const _BottomSheetTextWidget(
                          text: 'Select days',
                        ),
                      ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          final hourItem = _hourController.selectedItem;
                          String hour = hourItem < 10
                              ? '0$hourItem'
                              : hourItem.toString();
                          final minuteItem = _minuteController.selectedItem;
                          String minute = minuteItem < 10
                              ? '0$minuteItem'
                              : minuteItem.toString();
                          String time = '$hour:$minute';
                          String selectedDays =
                              days.isEmpty ? 'Everyday' : days.join();
                          Alarm alarm = Alarm(
                            id: Random(DateTime.now().millisecondsSinceEpoch)
                                .nextInt(1000000),
                            time: time,
                            timeOfDay: timeOfDay,
                            days: selectedDays,
                            on: true,
                            type: type,
                          );
                          context
                              .read<AlarmBloc>()
                              .add(AlarmEvent.addAlarm(alarm));
                          context
                              .read<NotificationBloc>()
                              .add(NotificationEvent.add(alarm));
                          Navigator.of(context).pop();
                        },
                        child: const _BottomSheetTextWidget(
                          text: 'Add alarm',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _BottomSheetTextWidget extends StatelessWidget {
  const _BottomSheetTextWidget({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).dateStyle);
  }
}

class _ListWheelScrollView extends StatelessWidget {
  const _ListWheelScrollView({
    required FixedExtentScrollController controller,
    required this.countItems,
  }) : _controller = controller;

  final FixedExtentScrollController _controller;
  final int countItems;

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(
      controller: _controller,
      useMagnifier: true,
      magnification: 1.2,
      diameterRatio: 2,
      itemExtent: 30,
      children: List.generate(
        countItems,
        (index) => Text(
          index < 10 ? '0$index' : '$index',
          style: Theme.of(context).dateStyle,
        ),
      ),
    );
  }
}
