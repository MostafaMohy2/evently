import 'package:evently/core/models/category.dart';
import 'package:evently/core/models/event.dart';
import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/icons_extensions.dart';
import 'package:evently/core/utils/number_extensions.dart';
import 'package:evently/firebase/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    final category = categoriesMap[event.category] ?? categoriesList.last;
    final isLight = context.appConfig.isLight;
    final imagePath = isLight ? category.imageLight : category.imageDark;

    return AspectRatio(
      aspectRatio: 343 / 193,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imagePath)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colorScheme.surface,
                border: Border.all(
                  color: context.colorScheme.primary,
                  width: 0.2,
                ),
              ),
              child: Text(
                DateFormat('MMM dd').format(event.dateTime!),
                style: context.textTheme.titleLarge!.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.colorScheme.surface,
                border: Border.all(
                  color: context.colorScheme.primary,
                  width: 0.2,
                ),
              ),
              child: Row(
                children: [
                  16.horizontalSpace,
                  Expanded(
                    child: Text(
                      event.title!,
                      style: context.textTheme.titleLarge!.copyWith(
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      var uid = FirebaseAuth.instance.currentUser?.uid ?? '';
                      if (event.likes.contains(uid)) {
                        event.likes.remove(uid);
                      } else {
                        event.likes.add(uid);
                      }
                      FirebaseDatabase().updateEvent(event);
                    },
                    icon:
                        event.likes.contains(
                          FirebaseAuth.instance.currentUser?.uid ?? '',
                        )
                        ? Icons.favorite.toIcon
                        : Icons.favorite_border.toIcon,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
