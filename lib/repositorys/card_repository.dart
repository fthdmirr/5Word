import 'package:fiveword/word_cards/models/card_model.dart';


abstract class CardRepository {
  Future<void> addNewCard(CardModel card);
  Future<void> deleteCard(CardModel card);
  Future<void> updateCard(CardModel card);

  Stream<List<CardModel>> cards();
}
