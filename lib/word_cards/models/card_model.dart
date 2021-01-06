import 'package:fiveword/word_cards/entities/card_entities.dart';
import 'package:meta/meta.dart';

@immutable
class CardModel {
  final String cardID;
  final String cardName;
  final Map<String, dynamic> words;
  final String cardNotificationFrequence;
  final String cardAddedDate;
  final bool isActive;

  CardModel({
    this.words,
    this.cardID,
    this.cardName,
    this.cardNotificationFrequence,
    this.cardAddedDate,
    this.isActive,
  });

  CardModel copyWith({
    String cardID,
    String cardName,
    Map<String, dynamic> words,
    String cardNotificationFrequence,
    String cardAddedDate,
    bool isActive,
  }) {
    return CardModel(
      cardID: cardID ?? this.cardID,
      cardName: cardName ?? this.cardName,
      words: words ?? this.words,
      cardNotificationFrequence:
          cardNotificationFrequence ?? this.cardNotificationFrequence,
      cardAddedDate: cardAddedDate ?? this.cardAddedDate,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  int get hashCode =>
      cardID.hashCode ^
      cardName.hashCode ^
      words.hashCode ^
      cardNotificationFrequence.hashCode ^
      cardAddedDate.hashCode ^
      isActive.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardModel &&
          runtimeType == other.runtimeType &&
          cardID == other.cardID &&
          words == other.words &&
          cardNotificationFrequence == other.cardNotificationFrequence &&
          cardAddedDate == other.cardAddedDate &&
          isActive == other.isActive;

  CardEntities toEntitiy() {
    return CardEntities(cardID, cardName, words, cardNotificationFrequence,
        cardAddedDate, isActive);
  }

  static CardModel fromEntitiy(CardEntities cardEntities) {
    return CardModel(
      cardID: cardEntities.cardID,
      cardName: cardEntities.cardName,
      words: cardEntities.words,
      cardNotificationFrequence: cardEntities.cardNotificationFrequence,
      cardAddedDate: cardEntities.cardAddedDate,
      isActive: cardEntities.isActive,
    );
  }
}
