import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/models/event.dart';

class FirebaseDatabase {
  FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference<Event> getCollectionReference() {
    return db
        .collection('events')
        .withConverter<Event>(
          fromFirestore: Event.fromFireStore,
          toFirestore: (Event event, _) => event.toFirestore(),
        );
  }

  Future<void> addEvent(Event event) async {
    var ref = getCollectionReference();
    var doc = ref.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  Future<List<Event>> getEventList() async {
    var ref = getCollectionReference();
    var snapshot = await ref.get();
    var events = snapshot.docs.map((event) => event.data()).toList();
    events.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
    return events;
  }

  Future<void> updateEvent(Event event) async {
    var ref = getCollectionReference();
    await ref.doc(event.id).update(event.toFirestore());
  }

  Future<void> deleteEvent(String id) async {
    var ref = getCollectionReference();
    await ref.doc(id).delete();
  }


  Stream<QuerySnapshot<Event>> getEventsStream({
    String? category,
    String? uid,
    String? query
  }) {
    var ref = getCollectionReference();

    return ref
        .where('category', isEqualTo: category)
        .where('likes', arrayContains: uid)
        .snapshots();
  }
}
