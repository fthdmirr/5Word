

import 'package:fiveword/word_cards/add_card/widget/add_button.dart';
import 'package:fiveword/word_cards/bloc/card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  // final Color _containerColor = Colors.amber[100];
  final TextStyle _textStyle = GoogleFonts.andika(
    color: Colors.blueGrey,
  );

  TextEditingController title = TextEditingController();
  TextEditingController w1 = TextEditingController();
  TextEditingController w2 = TextEditingController();
  TextEditingController w3 = TextEditingController();
  TextEditingController w4 = TextEditingController();
  TextEditingController w5 = TextEditingController();
  TextEditingController w6 = TextEditingController();
  TextEditingController w7 = TextEditingController();
  TextEditingController w8 = TextEditingController();
  TextEditingController w9 = TextEditingController();
  TextEditingController w10 = TextEditingController();
  int cardNotificationFrequency = 60;

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) => Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: Colors.blue,
                title: Text('Kart Ekle',
                    style: TextStyle(fontSize: 30, color: Colors.white)),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: _screenHeight / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: TextFormField(
                  controller: title,
                  decoration: InputDecoration(hintText: "Kartına bir isim ver"),
                  validator: (String value) {
                    if (value.length < 1) {
                      return "Lütfen bir şeyler yaz";
                    } else
                      return null;
                  },
                  onSaved: (newValue) {
                    title.text = newValue;
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: _screenHeight / 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Bildirim sıklığı:",
                      style: TextStyle(fontSize: _screenHeight / 40),
                    ),
                    _notificationsDropdown(),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: _screenHeight / 30,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _cardContainer(
                      screenHeight: _screenHeight,
                      word: w1,
                      word2: w2,
                    ),
                    _cardContainer(
                      screenHeight: _screenHeight,
                      word: w3,
                      word2: w4,
                    ),
                    _cardContainer(
                      screenHeight: _screenHeight,
                      word: w5,
                      word2: w6,
                    ),
                    _cardContainer(
                      screenHeight: _screenHeight,
                      word: w7,
                      word2: w8,
                    ),
                    _cardContainer(
                      screenHeight: _screenHeight,
                      word: w9,
                      word2: w10,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: AddButton(
                    title: title,
                    cardNotificationFrequency: cardNotificationFrequency,
                    formKey: _formKey,
                    w1: w1,
                    w2: w2,
                    w3: w3,
                    w4: w4,
                    w5: w5,
                    w6: w6,
                    w7: w7,
                    w8: w8,
                    w9: w9,
                    w10: w10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _cardContainer(
      {var screenHeight,
      TextEditingController word,
      TextEditingController word2}) {
    return Padding(
      padding: EdgeInsets.all(screenHeight / 250),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(screenHeight / 200),
        child: Padding(
          padding: EdgeInsets.all(screenHeight / 500),
          child: Card(
            color: Colors.orange[200],
            child: Padding(
              padding: EdgeInsets.all(screenHeight / 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "İlk Kelime:",
                    style: _textStyle,
                  ),
                  TextFormField(
                    controller: word,
                    onSaved: (value) {
                      word.text = value;
                    },
                    validator: (String value) {
                      if (value.length < 1) {
                        return "Burayı boş bırakamazsın";
                      } else
                        return null;
                    },
                  ),
                  SizedBox(
                    height: screenHeight / 100,
                  ),
                  Text(
                    "İkinci Kelime:",
                    style: _textStyle,
                  ),
                  TextFormField(
                    controller: word2,
                    onSaved: (value) {
                      word2.text = value;
                    },
                    validator: (String value) {
                      if (value.length < 1) {
                        return "Burayı boş bırakamazsın";
                      } else
                        return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DropdownButton _notificationsDropdown() => DropdownButton<int>(
      hint: Text(
        "Select",
        style: GoogleFonts.andika(
            fontSize: MediaQuery.of(context).size.height / 40),
      ),
      items: [
        DropdownMenuItem(
          child: Text("15 Dakika"),
          value: 15,
        ),
        DropdownMenuItem(
          child: Text("30 Dakika"),
          value: 30,
        ),
        DropdownMenuItem(
          child: Text("45 Dakika"),
          value: 45,
        ),
        DropdownMenuItem(
          child: Text("1 Saat"),
          value: 60,
        ),
        DropdownMenuItem(
          child: Text("2 Saat"),
          value: 120,
        ),
        DropdownMenuItem(
          child: Text("3 Saat"),
          value: 180,
        ),
      ],
      value: cardNotificationFrequency,
      onChanged: (value) {
        setState(() {
          cardNotificationFrequency = value;
        });
      });

  @override
  void dispose() {
    title.dispose();
    w1.dispose();
    w2.dispose();
    w3.dispose();
    w4.dispose();
    w5.dispose();
    w6.dispose();
    w7.dispose();
    w8.dispose();
    w9.dispose();
    w10.dispose();
    super.dispose();
  }
}
