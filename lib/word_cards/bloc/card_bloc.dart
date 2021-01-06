import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fiveword/repositorys/card_repository.dart';
import 'package:fiveword/word_cards/models/card_model.dart';

import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository _cardRepository;
  StreamSubscription _cardSubscription;

  CardBloc({@required CardRepository cardRepository})
      : assert(cardRepository != null),
        _cardRepository = cardRepository,
        super(CardsLoadedState());

  @override
  Stream<CardState> mapEventToState(
    CardEvent event,
  ) async* {
    if (event is CardsLoadSuccessEvent) {
      yield* _mapLoadedCardToState();
    } else if (event is CardsAddedEvent) {
      yield* _mapAddCardsToState(event);
    } else if (event is CardsUpdatedEvent) {
      yield* _mapUpdatedToState(event);
    } else if (event is CardsDeleteEvent) {
      yield* _mapDeleteCardToState(event);
    } else if (event is UpdateCardsEvent) {
      yield* _mapUpdateCardsToState(event);
    }
  }

  Stream<CardState> _mapLoadedCardToState() async* {
    _cardSubscription?.cancel();
    _cardSubscription =
        _cardRepository.cards().listen((cards) => add(UpdateCardsEvent(cards)));
  }

  Stream<CardState> _mapAddCardsToState(CardsAddedEvent event) async* {
    yield CardsLoadingState();
    await _cardRepository.addNewCard(event.cards);
    //NotificationManager.scheduleNotification(id: event.cardNotificationID,notificationFrequence: event.cardFrequence);
    yield CardsLoadedState();
  }

  Stream<CardState> _mapUpdatedToState(CardsUpdatedEvent event) async* {
    yield CardsLoadingState();
    await _cardRepository.updateCard(event.cards);
    yield CardsLoadedState();
  }

  Stream<CardState> _mapDeleteCardToState(CardsDeleteEvent event) async* {
    yield CardsLoadingState();
    await _cardRepository.deleteCard(event.cards);
    yield CardsLoadedState();
  }

  Stream<CardState> _mapUpdateCardsToState(UpdateCardsEvent event) async* {
    yield CardsLoadedState(event.cards);
  }

  @override
  Future<void> close() {
    _cardSubscription?.cancel();
    return super.close();
  }
}
