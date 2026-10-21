import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/models/event.dart';
import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/icons_extensions.dart';
import 'package:evently/core/utils/number_extensions.dart';
import 'package:evently/core/utils/widget_extensions.dart';
import 'package:evently/firebase/firebase_database.dart';
import 'package:evently/screens/event_management/event_details_screen.dart';
import 'package:evently/screens/widgets/event_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              suffixIcon: Icons.search_outlined.toIcon,
            ),
          ).allPadding(16),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Event>>(
              stream: FirebaseDatabase().getEventsStream(
                uid: FirebaseAuth.instance.currentUser?.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == .waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  var event =
                      snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                  event.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));

                  if (event.isEmpty) {
                    return Center(child: Text('no events found'));
                  } else {
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            EventDetailsScreen.route,
                            arguments: event[index],
                          );
                        },
                        child: EventCard(event: event[index]),
                      ),
                      separatorBuilder: (_, _) => 16.verticalSpace,
                      itemCount: event.length,
                    );
                  }
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
