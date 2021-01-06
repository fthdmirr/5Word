import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fiveword/repositorys/card_repository.dart';
import 'package:fiveword/word_cards/entities/card_entities.dart';
import 'package:fiveword/word_cards/models/card_model.dart';


class FirebaseCardRepository implements CardRepository {
  final _cardCollection = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("Cards");

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Future<void> addNewCard(CardModel cardModel) async {
    var _token = await _firebaseMessaging.getToken();
    FirebaseFirestore.instance
        .collection("DeviceToken")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({'deviceToken': _token});
    return _cardCollection.add(cardModel.toEntitiy().toDocument());
  }

  @override
  Future<void> deleteCard(CardModel cardModel) {
    return _cardCollection.doc(cardModel.cardID).delete();
  }

  @override
  Future<void> updateCard(CardModel cardModel) {
    return _cardCollection
        .doc(cardModel.cardID)
        .update(cardModel.toEntitiy().toDocument());
  }

  @override
  Stream<List<CardModel>> cards() {
    return _cardCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CardModel.fromEntitiy(CardEntities.fromSnapshot(doc)))
          .toList();
    });
  }
}
