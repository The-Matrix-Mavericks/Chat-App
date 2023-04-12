import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';

import 'Example.dart';

class Checkup extends StatelessWidget {
  final AppinioSwiperController controller = AppinioSwiperController();
  final data = [
    "do you have itching ?",
    "do you have acidity ?",
    "do you have skin_rash ?",
    "do you have vomiting ?",
    "do you have burning_micturition ?",
    "do you have weight_gain ?",
    "do you have cold_hands_and_feets ?",
    "do you have indigestion ?",
    "do you have yellowish_skin ?",
    "do you have dark_urine ?",
    "do you have loss_of_appetite ?",
    "do you have back_pain ?",
    "do you have abdominal_pain ?",
    "do you have chest_pain ?",
    "do you have fast_heart_rate ?",
    "do you have bloody_stool ?",
    "do you have neck_pain ?",
    "do you have cramps ?",
    "do you have swollen_legs ?",
    "do you have knee_pain ?",
    "do you have movement_stiffness ?",
    "do you have unsteadiness ?",
    "do you have altered_sensorium ?",
    "do you have watering_from_eyes ?",
    "do you have rusty_sputum ?",
    "do you have visual_disturbances ?",
    "do you have receiving_unsterile_injections ?",
    "do you have blood_in_sputum ?",
    "do you have skin_peeling ?",
    "do you have small_dents_in_nails ?",
    "do you have painful_walking ?",
    "do you have blood_in_sputum ?",
    "do you have history_of_alcohol_consumption ?",
    "do you have palpitations ?",
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Get Instant checkup")),
        ),
        body: CupertinoPageScaffold(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: AppinioSwiper(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 20,
                    bottom: 20,
                  ),
                  allowUnswipe: true,
                  unlimitedUnswipe: true,
                  threshold: 50,
                  controller: controller,
                  duration: const Duration(milliseconds: 500),
                  cardsCount: data.length,
                  maxAngle: 140,
                  cardsBuilder: (BuildContext context, int index) {
                    return ExampleCard(candidate: data[index]);
                  },
                ),
              ),
              SizedBox(
                height: size.height / 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}







// import 'Example.dart';

// class Checkup extends StatelessWidget {
//   const Checkup({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const CupertinoApp(
//       debugShowCheckedModeBanner: false,
//       home: Example(),
//     );
//   }
// }

// class Example extends StatefulWidget {
//   const Example({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<Example> createState() => _ExamplePageState();
// }

// class _ExamplePageState extends State<Example> {
//   f
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 50,
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.75,
//             child: AppinioSwiper(
//               swipeOptions: AppinioSwipeOptions.vertical,
//               unlimitedUnswipe: true,
//               controller: controller,
//               unswipe: _unswipe,
//               onSwipe: _swipe,
//               padding: const EdgeInsets.only(
//                 left: 25,
//                 right: 25,
//                 top: 50,
//                 bottom: 40,
//               ),
//               onEnd: _onEnd,
//               cardsCount: candidates.length,
//               cardsBuilder: (BuildContext context, int index) {
//                 return ExampleCard(
//                   candidate: candidates[index],
//                 );
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 width: 80,
//               ),
//               // swipeLeftButton(controller),
//               const SizedBox(
//                 width: 20,
//               ),
//               // swipeRightButton(controller),
//               const SizedBox(
//                 width: 20,
//               ),
//               // unswipeButton(controller),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   void _swipe(int index, AppinioSwiperDirection direction) {
//     log("the card was swiped to the: " + direction.name);
//   }

//   void _unswipe(bool unswiped) {
//     if (unswiped) {
//       log("SUCCESS: card was unswiped");
//     } else {
//       log("FAIL: no card left to unswipe");
//     }
//   }

//   void _onEnd() {
//     log("end reached!");
//   }

//   swipeLeftButton(AppinioSwiperController controller) {}

//   swipeRightButton(AppinioSwiperController controller) {}

//   unswipeButton(AppinioSwiperController controller) {}
// }
