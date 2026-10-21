import 'package:evently/core/models/event.dart';
import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/date_time_extesions.dart';
import 'package:evently/core/utils/validator.dart';
import 'package:evently/core/utils/widget_extensions.dart';
import 'package:evently/core/models/category.dart';
import 'package:evently/firebase/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/number_extensions.dart';
import '../widgets/custom_tab_bar.dart';

class EventManagementScreen extends StatefulWidget {
  static const String route = '/event_management';
  const EventManagementScreen({super.key});

  @override
  State<EventManagementScreen> createState() => _EventManagementScreenState();
}

class _EventManagementScreenState extends State<EventManagementScreen> {
  List<Category> categories = [...categoriesList];
  int selectedIndex = 0;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    var validator = Validator();
    final event = ModalRoute.of(context)?.settings.arguments as Event?;
    final bool isEditing = event != null;

    if (isEditing && titleController.text.isEmpty) {
      titleController.text = event.title ?? '';
      descController.text = event.descritpion ?? '';
      date = event.dateTime;
      time = event.timeOfDay;
      final categoryIndex =
          categories.indexWhere((c) => c.id == event.category);
      if (categoryIndex != -1) {
        selectedIndex = categoryIndex;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Event' : 'Add Event'),
        centerTitle: true,
      ),
      bottomNavigationBar: FilledButton(
        onPressed: () async {
          if (titleController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Title is required')),
            );
            return;
          }

          if (descController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Description is required')),
            );
            return;
          }

          if (date == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Date is required')),
            );
            return;
          }

          if (time == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Time is required')),
            );
            return;
          }

          await context.showActionDialog(
            title: isEditing ? 'Update Event' : 'Add Event',
            message: isEditing
                ? 'Are you sure you want to update this event?'
                : 'Are you sure you want to add this event?',
            postActionTitle: 'Yes',
            negativeActionTitle: 'No',
            postAction: () async {
              context.showDialogUtils();
              await Future.delayed(const Duration(milliseconds: 300));

              final eventToSave = Event(
                id: isEditing ? event.id : null,
                uid: FirebaseAuth.instance.currentUser?.uid ?? '',
                title: titleController.text,
                descritpion: descController.text,
                dateTime: date!,
                timeOfDay: time!,
                category: categories[selectedIndex].id,
              );

              if (isEditing) {
                await FirebaseDatabase().updateEvent(eventToSave);
              } else {
                await FirebaseDatabase().addEvent(eventToSave);
              }
              //ignore: use_build_context_synchronously
              context.pop();
              //ignore: use_build_context_synchronously
              context.pop();
            },
          );
        },
        child: Text(
          isEditing ? 'Update Event' : 'Add Event',
          style: context.textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
      ).allPadding(16),
      body: ListView(
        children: [
          Stack(
            children: [
              Image.asset(
                context.appConfig.isLight
                    ? categories[selectedIndex].imageLight
                    : categories[selectedIndex].imageDark,
              ).clip(16).allPadding(16),
              const AspectRatio(
                aspectRatio: 343 / 193,
                child: SizedBox(width: double.infinity),
              ),
            ],
          ),
          CustomTabBar(
            categories: categories,
            selectedIndex: selectedIndex,
            selectEvent: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          16.verticalSpace,
          Text(
            'Title',
            style: context.textTheme.titleMedium,
          ).horizontalPadding(16),
          8.verticalSpace,
          TextFormField(
            controller: titleController,
            validator: (input) =>
                validator.nameValidator(input, context.locale),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Enter Title...',
              hintStyle: context.textTheme.bodyLarge,
            ),
          ).horizontalPadding(16),
          16.verticalSpace,
          Text(
            'Description',
            style: context.textTheme.titleMedium,
          ).horizontalPadding(16),
          8.verticalSpace,
          TextFormField(
            controller: descController,
            validator: (input) =>
                validator.nameValidator(input, context.locale),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Enter Description...',
              hintStyle: context.textTheme.bodyLarge,
            ),
          ).horizontalPadding(16),
          16.verticalSpace,
          Row(
            children: [
              Icon(Icons.calendar_month, color: context.colorScheme.primary),
              5.horizontalSpace,
              const Text('Event Date'),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: date,
                    lastDate: DateTime.now().add(const Duration(days: 500)),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      date = pickedDate;
                    });
                  }
                },
                child: Text(
                  date == null
                      ? 'Choose Date'
                      : DateFormat('d/M/yyyy').format(date!),
                ),
              ),
            ],
          ).horizontalPadding(16),
          Row(
            children: [
              Icon(
                Icons.watch_later_outlined,
                color: context.colorScheme.primary,
              ),
              5.horizontalSpace,
              const Text('Event time'),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  var selectedTime = await showTimePicker(
                    context: context,
                    initialTime: time ?? TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    setState(() {
                      time = selectedTime;
                    });
                  }
                },
                child: Text(
                  time == null
                      ? 'Choose time'
                      : DateFormat('h:mm a').format(time!.dateTime),
                ),
              ),
            ],
          ).horizontalPadding(16),
          24.verticalSpace,
        ],
      ),
    );
  }
}
