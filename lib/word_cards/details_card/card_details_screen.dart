
import 'package:fiveword/word_cards/bloc/card_bloc.dart';
import 'package:fiveword/word_cards/details_card/speech_text/speech_text_widget.dart';
import 'package:fiveword/word_cards/models/card_model.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class CardDetailScreen extends StatefulWidget {
  final Map<String, dynamic> cardWords;
  final cardID;
  CardDetailScreen({@required this.cardWords, @required this.cardID});

  @override
  _CardDetailScreenState createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    //CardController controller;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detay Sayfası"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: _screenHeight / 20,
              ),
              Expanded(
                child: TinderSwapCard(
                  orientation: AmassOrientation.BOTTOM,
                  totalNum: widget.cardWords.length,
                  stackNum: 3,
                  swipeEdge: 4.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.width * 0.9,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: MediaQuery.of(context).size.width * 0.8,
                  cardBuilder: (context, index) {
                    return Card(
                      child: FlipCard(
                        direction: FlipDirection.HORIZONTAL,
                        front: Center(
                          child: Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.width * 0.9,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.cardWords.keys
                                      .toList()[index]
                                      .toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                                CardSpeechText(
                                  widget.cardWords.keys
                                      .toList()[index]
                                      .toString(),
                                )
                              ],
                            )),
                          ),
                        ),
                        back: Center(
                          child: Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.width * 0.9,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.cardWords.values
                                      .toList()[index]
                                      .toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                                CardSpeechText(
                                  widget.cardWords.values
                                      .toList()[index]
                                      .toString(),
                                ),
                              ],
                            )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: _screenHeight / 20,
              ),
              SizedBox(
                height: _screenHeight / 15,
              ),
              BlocBuilder<CardBloc, CardState>(
                builder: (context, state) {
                  return FloatingActionButton.extended(
                    backgroundColor: Colors.red,
                    label: const Text("Kartı Sil"),
                    onPressed: () {
                      BlocProvider.of<CardBloc>(context).add(
                          CardsDeleteEvent(CardModel(cardID: widget.cardID)));

                      Navigator.pop(context);
                    },
                  );
                },
              ),
              SizedBox(
                height: _screenHeight / 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
