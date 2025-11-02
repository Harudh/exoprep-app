import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

Future<void> showDurationPicker({
  required BuildContext context,
  required Function(Duration) onDurationSelected,
  Duration? initialDuration,
}) {
  var selectedDuration = initialDuration ?? const Duration(hours: 1);

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF2A2A2A)
              : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            // Header with Done button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: context.bodyLarge!.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      onDurationSelected(selectedDuration);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: context.bodyLarge!.copyWith(
                        color: context.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Time Picker
            Expanded(
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: selectedDuration,
                onTimerDurationChanged: (Duration duration) {
                  selectedDuration = duration;
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
