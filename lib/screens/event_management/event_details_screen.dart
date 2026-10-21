import 'package:evently/core/models/category.dart';
import 'package:evently/core/models/event.dart';
import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/date_time_extesions.dart';
import 'package:evently/core/utils/number_extensions.dart';
import 'package:evently/firebase/firebase_database.dart';
import 'package:evently/screens/event_management/event_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String route = '/event_details';

  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)?.settings.arguments as Event?;

    final category = categoriesMap[event?.category] ?? categoriesList.last;
    final imagePath = context.appConfig.isLight
        ? category.imageLight
        : category.imageDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                EventManagementScreen.route,
                arguments: event,
              );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _deleteEvent(context, event!),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          16.verticalSpace,
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 343 / 193,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          16.verticalSpace,

          Text(
            event!.title ?? '',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.primary,
            ),
          ),
          16.verticalSpace,

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.colorScheme.primary,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                16.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.dateTime != null
                          ? DateFormat('d MMMM').format(event.dateTime!)
                          : '',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      event.timeOfDay != null
                          ? 'at ${DateFormat('h:mm a').format(event.timeOfDay!.dateTime)}'
                          : '',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          16.verticalSpace,

          Text(
            'Description',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.secondary,
            ),
          ),
          8.verticalSpace,

          Text(
            event.descritpion ?? '',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.secondary,
              height: 1.5,
            ),
          ),
          24.verticalSpace,
        ],
      ),
    );
  }

  Future<void> _deleteEvent(BuildContext context, Event event) async {
    await context.showActionDialog(
      title: 'Delete Event',
      message: 'Are you sure you want to delete this event?',
      postActionTitle: 'Delete',
      negativeActionTitle: 'Cancel',
      postAction: () async {
        context.showDialogUtils();
        await FirebaseDatabase().deleteEvent(event.id!);
        if (!context.mounted) return;
        context.pop();
        context.pop();
      },
    );
  }
}
