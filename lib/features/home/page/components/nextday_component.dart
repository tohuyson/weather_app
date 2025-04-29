import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/colors.dart';
import 'package:weather_app/common/constants.dart';
import 'package:weather_app/common/styles.dart';

class NextDayComponent extends StatefulWidget {
  const NextDayComponent({super.key, this.averageTempNextFourDays = const {}});

  final Map<DateTime, String> averageTempNextFourDays;

  @override
  State<NextDayComponent> createState() => _NextDayComponentState();
}

class _NextDayComponentState extends State<NextDayComponent> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: AppConstants.animationDuration, vsync: this);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: _controller, curve: AppConstants.animationCurve)),
      child: Container(
        decoration: BoxDecoration(color: UIColors.white),
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: widget.averageTempNextFourDays.length,
          physics: AppConstants.physics,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final day = widget.averageTempNextFourDays.keys.toList()[index];
            final temp = widget.averageTempNextFourDays[day] ?? 0;
            final datText = DateFormat('EEEE', 'vi').format(day);
            return SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(datText, style: UITextStyle.regular.copyWith(fontSize: 16, height: 1.2)),
                  Text('$temp C', style: UITextStyle.regular.copyWith(fontSize: 16, height: 1.2)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
