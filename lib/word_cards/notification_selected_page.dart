import 'package:fiveword/word_cards/bloc/card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSelectedPage extends StatefulWidget {
  final String id;

  NotificationSelectedPage({this.id});

  @override
  _NotificationSelectedPageState createState() =>
      _NotificationSelectedPageState();
}

class _NotificationSelectedPageState extends State<NotificationSelectedPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController word1 = TextEditingController();
  final TextEditingController word2 = TextEditingController();
  final TextEditingController word3 = TextEditingController();
  final TextEditingController word4 = TextEditingController();
  final TextEditingController word5 = TextEditingController();

  List<TextEditingController> wordsList = List<TextEditingController>();

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;
    wordsList = [word1, word2, word3, word4, word5];
    return Scaffold(
      appBar: AppBar(
        title: Text("Tekrar Vakti"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_screenHeight / 100),
          child: BlocBuilder<CardBloc, CardState>(
            builder: (context, state) {
              final card = (state as CardsLoadedState).cards.firstWhere(
                  (cards) => cards.cardID == widget.id,
                  orElse: () => null);
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: card.words.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: _screenHeight / 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.deepOrange),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        card.words.keys
                                                .toList()[index]
                                                .toString() +
                                            ": ",
                                        style: TextStyle(
                                            fontSize: _screenWidth / 15),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextFormField(
                                        decoration: InputDecoration(),
                                        controller: wordsList[index],
                                        onSaved: (String value) {
                                          wordsList[index].text = value;
                                        },
                                        validator: (String value) {
                                          if (value !=
                                              card.words.values
                                                  .toList()[index]
                                                  .toString()) {
                                            return "Yanlış yazdınız, lütfen bir daha deneyiniz?";
                                          } else
                                            return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  FloatingActionButton.extended(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                        }
                      },
                      label: Text("Kontrol Et")),
                  SizedBox(
                    height: _screenHeight / 20,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    word1.dispose();
    word2.dispose();
    word3.dispose();
    word4.dispose();
    word5.dispose();

    super.dispose();
  }
}
