import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CardEntities extends Equatable {
  final String cardID;
  final String cardName;
  final Map<String, dynamic> words;
  final String cardNotificationFrequence;
  final String cardAddedDate;
  final bool isActive;

  const CardEntities(this.cardID, this.cardName, this.words,
      this.cardNotificationFrequence, this.cardAddedDate,this.isActive);

  Map<String, dynamic> toJson() {
    return {
      'cardID': cardID,
      'cardName': cardName,
      'words': words,
      'cardNotificationFrequence': cardNotificationFrequence,
      'cardAddedDate': cardAddedDate
    };
  }

  @override
  List<Object> get props =>
      [cardID, cardName, words, cardNotificationFrequence, cardAddedDate];

  static CardEntities fromJson(Map<String, dynamic> json) {
    return CardEntities(
        json['id'] as String,
        json['cardName'] as String,
        json['words'] as Map<String, dynamic>,
        json['cardNotificationFrequence'] as String,
        json['cardAddedDate'] as String,
        json['isActive'] as bool,
        
        );
  }

  static CardEntities fromSnapshot(DocumentSnapshot snap) {
    return CardEntities(
      snap.id,
      snap.data()['cardName'],
      snap.data()['words'],
      snap.data()['cardNotificationFrequence'],
      snap.data()['cardAddedDate'],
      snap.data()['isActive'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'cardName': cardName,
      'words': words,
      'cardNotificationFrequence': cardNotificationFrequence,
      'cardAddedDate': cardAddedDate,
      'isActive': isActive,
    };
  }
}
