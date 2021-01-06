
import 'package:fiveword/fab_menu/circular_button.dart';
import 'package:fiveword/random_words/random_words_page.dart';
import 'package:fiveword/settings/settings_screen.dart';
import 'package:fiveword/word_cards/add_card/card_add_screen.dart';
import 'package:flutter/material.dart';

class FabMenu extends StatefulWidget {
  @override
  _FabMenuState createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;

  Animation rotationAnimation;
  Animation rotationAnimationForChilds;

  double getRadiansFromDegree(double degree) {
    const double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 260));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 225.0, end: 45.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    rotationAnimationForChilds = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          right: size.height / 80,
          bottom: size.height / 80,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              IgnorePointer(
                child: Container(
                  color: Colors.black.withOpacity(
                      0.0), // comment or change to transparent color
                  height: size.height / 4,
                  width: size.height / 4,
                ),
              ),
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(270),
                    degOneTranslationAnimation.value * 100),
                child: Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimationForChilds.value))
                    ..scale(degOneTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: CircularButton(
                    color: Colors.blue,
                    width: size.height / 15,
                    height: size.height / 15,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddCardScreen(),
                          ));
                    },
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(225),
                    degTwoTranslationAnimation.value * 100),
                child: Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimationForChilds.value))
                    ..scale(degTwoTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: CircularButton(
                    color: Colors.orangeAccent,
                    width: size.height / 15,
                    height: size.height / 15,
                    icon: const Icon(
                      Icons.library_books,
                      color: Colors.white,
                    ),
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RandomWordsPage(),
                          ));
                    },
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(180),
                    degThreeTranslationAnimation.value * 100),
                child: Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimationForChilds.value))
                    ..scale(degThreeTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: CircularButton(
                    color: Colors.black,
                    width: size.height / 15,
                    height: size.height / 15,
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()));
                    },
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(rotationAnimation.value)),
                alignment: Alignment.center,
                child: CircularButton(
                  color: Colors.red,
                  width: size.height / 10,
                  height: size.height / 13,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onClick: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                    } else {
                      animationController.forward();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
