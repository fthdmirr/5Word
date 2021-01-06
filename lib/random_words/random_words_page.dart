import 'package:fiveword/random_words/cubit/counter_cubit.dart';
import 'package:fiveword/random_words/random_word_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomWordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rastgele kelimelerden ekle"),
          actions: [
            Center(child: BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                return Text(
                  "$state" + "/5",
                  style: TextStyle(fontSize: 20),
                );
              },
            )),
            SizedBox(
              width: _screenHeight / 30,
            ),
          ],
        ),
        body: RandomWordList(),
      ),
    );
  }
}
