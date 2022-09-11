import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_calculator/model/single_room.dart';

class DatabaseManager {
  final CollectionReference roomsList =
      FirebaseFirestore.instance.collection('roomsInfo');

  Future<List> getRoomsList() async {
    List roomsListData = [];
    try {
      final snapshot = roomsList.doc("f0QEeIoPnAykg1cA2NYG").get();
      roomsListData = await snapshot.then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        roomsListData.add(data['room']);
        return data['room'];
      }) as List;
      return roomsListData;
    } catch (e) {
      print(e);
      return roomsListData;
    }
  }

  Future<SingleRoom> fetchSingleRoom() async {
    SingleRoom resp;
    try {
      final snapshot = roomsList.doc("singleRoom").get();
      resp = await snapshot.then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return SingleRoom(data['name'], data['current_units'],
            data['prev_units'], data['maintenance'], data['price_per_unit']);
      });
      return resp;
    } catch (e) {
      return SingleRoom("", 0, 0, 0, 0);
    }
  }
}
