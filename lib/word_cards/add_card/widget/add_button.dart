
import 'package:fiveword/word_cards/bloc/card_bloc.dart';
import 'package:fiveword/word_cards/models/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AddButton extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController w1;
  final TextEditingController w2;
  final TextEditingController w3;
  final TextEditingController w4;
  final TextEditingController w5;
  final TextEditingController w6;
  final TextEditingController w7;
  final TextEditingController w8;
  final TextEditingController w9;
  final TextEditingController w10;
  final int cardNotificationFrequency;
  final formKey;
  String _formattedDate = DateFormat('dd-MM-yyyy-kk:mm').format(DateTime.now());
  AddButton(
      {this.title,
      this.cardNotificationFrequency,
      this.formKey,
      this.w1,
      this.w2,
      this.w3,
      this.w4,
      this.w5,
      this.w6,
      this.w7,
      this.w8,
      this.w9,
      this.w10});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
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
        onTap: () async {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            BlocProvider.of<CardBloc>(context).add(
              CardsAddedEvent(
                CardModel(
                  cardName: toBeginningOfSentenceCase(title.text),
                  cardNotificationFrequence:
                      1.toString(),
                  cardAddedDate: _formattedDate,
                  words: {
                    w1.text.trim(): w2.text.trim(),
                    w3.text.trim(): w4.text.trim(),
                    w5.text.trim(): w6.text.trim(),
                    w7.text.trim(): w8.text.trim(),
                    w9.text.trim(): w10.text.trim(),
                  },
                  isActive: true,
                ),
              ),
            );
            BlocProvider.of<CardBloc>(context).add(CardsLoadSuccessEvent());
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
