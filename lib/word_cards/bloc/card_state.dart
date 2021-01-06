part of 'card_bloc.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

class CardsLoadingState extends CardState {}

class CardsLoadedState extends CardState {
  final List<CardModel> cards;
  const CardsLoadedState([this.cards = const []]);
  @override
  List<Object> get props => [cards];
}

class CardsErrorState extends CardState {}
