part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class CardsLoadSuccessEvent extends CardEvent {}

class CardsAddedEvent extends CardEvent {
  final CardModel cards;
  const CardsAddedEvent(this.cards);
  @override
  List<Object> get props => [cards];
}

class UpdateCardsEvent extends CardEvent {
  final List<CardModel> cards;
  const UpdateCardsEvent(this.cards);
  @override
  List<Object> get props => [cards];
}

class CardsUpdatedEvent extends CardEvent {
  final CardModel cards;
  const CardsUpdatedEvent(this.cards);
  @override
  List<Object> get props => [cards];
}

class CardsDeleteEvent extends CardEvent {
  final CardModel cards;
  const CardsDeleteEvent(this.cards);
  @override
  List<Object> get props => [cards];
}
