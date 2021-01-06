
import 'package:fiveword/word_cards/bloc/card_bloc.dart';
import 'package:fiveword/word_cards/details_card/card_details_screen.dart';
import 'package:fiveword/word_cards/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordCards extends StatefulWidget {
  @override
  _WordCardsState createState() => _WordCardsState();
}

class _WordCardsState extends State<WordCards> {
  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<CardBloc, CardState>(builder: (context, state) {
      if (state is CardsLoadedState) {
        List<CardModel> cardsList = state.cards;

        return cardsList.length > 0
            ? GridView.builder(
                itemCount: cardsList.length,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardDetailScreen(
                                cardWords: cardsList[index].words,
                                cardID: cardsList[index].cardID,
                              ),
                            ));
                      },
                      child: Container(
                        height: _screenHeight / 15,
                        width: _screenHeight / 15,
                        child: Center(child: Text(cardsList[index].cardName)),
                        decoration: BoxDecoration(
                            backgroundBlendMode: BlendMode.hardLight,
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text("Lütfen bir kart ekleyiniz"),
              );
      } else if (state is CardsLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CardsErrorState) {
        return Center(
          child:
              Text("An unexpected error occurred, please check your Internet"),
        );
      } else
        return null;
    });
  }
}
