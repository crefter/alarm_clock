import 'package:alarm_clock/src/features/alarm/src/domain/alarm_bloc.dart';
import 'package:alarm_clock/src/features/alarm/src/domain/notification_bloc.dart';
import 'package:alarm_clock/src/features/alarm/widgets/alarm_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmsListWidget extends StatelessWidget {
  const AlarmsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        state.when(
          added: () => _showSnackBar(context, 'Alarm on!'),
          canceled: () => _showSnackBar(context, 'Alarm off!'),
          initial: () {},
        );
      },
      child: BlocBuilder<AlarmBloc, AlarmState>(
        buildWhen: (previous, current) {
          if (previous is AlarmPermissionGrantedState &&
              current is AlarmPermissionGrantedState) {
            final previousListLength = previous.maybeWhen(
                orElse: () => 0, permissionGranted: (alarms) => alarms.length);
            final currentListLength = current.maybeWhen(
                orElse: () => 0, permissionGranted: (alarms) => alarms.length);
            return previousListLength != currentListLength;
          } else {
            return previous != current;
          }
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SliverToBoxAdapter(
              child: SizedBox.shrink(),
            ),
            permissionGranted: (alarms) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 33,
                      right: 17,
                      left: 17,
                    ),
                    child: AlarmItemWidget(index: index),
                  );
                },
                childCount: alarms.length,
              ),
            ),
          );
        },
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showSnackBar(
    BuildContext context,
    String text,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          milliseconds: 1500,
        ),
        content: Text(text),
      ),
    );
  }
}
