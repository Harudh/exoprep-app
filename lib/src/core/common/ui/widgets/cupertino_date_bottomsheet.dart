import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:root/src/core/extensions/context_extension.dart';

Future<void> showDatePickerBottomSheet({
  required BuildContext context,
  required Function(DateTime) onDateSelected,
  DateTime? initialDate,
  String title = 'Select Date',
}) {
  var selectedDate = initialDate ?? DateTime.now();

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: 350,
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
            // Header with Cancel and Done buttons
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
                      onDateSelected(selectedDate);
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

            // Date Picker
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                minimumDate: DateTime(2020),
                maximumDate: DateTime(2030),
                onDateTimeChanged: (DateTime date) {
                  selectedDate = date;
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
