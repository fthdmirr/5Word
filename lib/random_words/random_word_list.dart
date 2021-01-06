
import 'package:fiveword/word_cards/bloc/card_bloc.dart';
import 'package:fiveword/word_cards/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomWordList extends StatefulWidget {
  @override
  _RandomWordListState createState() => _RandomWordListState();
}

class _RandomWordListState extends State<RandomWordList> {
  String text1 = "kelime";
  String text2 = "anlamı";
  //TODO:eklenenleri ayrı bi listeye ekle ve o listeden add butotuna ekle
  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actions: [
                        IconSlideAction(
                          caption: 'Ekle',
                          color: Colors.green,
                          icon: Icons.done,
                          onTap: () => context.read<CounterCubit>().increment(),
                        ),
                        IconSlideAction(
                          caption: 'İptal',
                          color: Colors.red,
                          icon: Icons.close,
                          onTap: () => context.read<CounterCubit>().decrement(),
                        )
                      ],
                      child: Container(
                        height: _screenHeight / 10,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(text1),
                            Text(text2),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _screenHeight / 50,
                    ),
                  ],
                );
              },
            ),
          ),
          BlocBuilder<CounterCubit, int>(
            builder: (context, state) {
              return GestureDetector(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Text(
                      "Ekle",
                      style: TextStyle(color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepOrangeAccent[100]),
                  ),
                  onTap: () {
                    state == 5
                        ? BlocProvider.of<CardBloc>(context).add(
                            CardsAddedEvent(CardModel(
                                cardName: "Kart İsmi",
                                cardAddedDate: "",
                                isActive: true,
                                cardNotificationFrequence: "30",
                                words: {
                                text1: text2,
                                text1: text2,
                                text1: text2,
                                text1: text2,
                                text1: text2,
                              })))
                        : print("toast göster");
                    Navigator.pop(context);
                  });
            },
          ),
        ],
      ),
    );
  }

  List<String> wordsList = [
    "abandon",
    "ability",
    "able",
    "abortion",
    "about",
    "above",
    "abroad",
    "absence",
    "absolute",
    "absolutely",
    "absorb",
    "abuse",
    "academic",
    "accept",
    "access",
    "accident",
    "accompany",
    "accomplish",
    "according",
    "account",
    "accurate",
    "accuse",
    "achieve",
    "achievement",
    "acid",
    "acknowledge",
  ];
}
