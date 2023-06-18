import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_multivender_ecommerce_app/screens/main_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const boardingRout = '/boarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _mycontroller = PageController(
    initialPage: 0,
  );

  double scrollViewPosition = 0;
  onButtonPressed(context) {
    store.write('onBoarding', true);
    return Navigator.pushReplacementNamed(context, MainScreen.routName);
  }

  final store = GetStorage();

  @override
  void dispose() {
    _mycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              onPageChanged: ((value) {
                setState(() {
                  scrollViewPosition = value.toDouble();
                });
              }),
              controller: _mycontroller,
              scrollDirection: Axis.horizontal,
              children: [
                OnBoardPage(
                  boardColumn: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome \n To Shop App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                      const Text(
                        '+1000 products \n +100 catagories',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset('lib/assets/images/loginn.png'),
                      )
                    ],
                  ),
                ),
                OnBoardPage(
                  boardColumn: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'sell product  \n get reward',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                      const Text(
                        'easy to use \n just signup and go ahed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset('lib/assets/images/loginm.png'),
                      )
                    ],
                  ),
                ),
                OnBoardPage(
                  boardColumn: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'good quality product \n with insurance',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                      const Text(
                        '7-14 replacement \n 1 year waranty',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset('lib/assets/images/logiin.png'),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 130,
                          decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          DotsIndicator(
                            dotsCount: 3,
                            position: scrollViewPosition,
                            decorator: const DotsDecorator(
                              activeColor: Colors.white,
                            ),
                          ),
                          scrollViewPosition == 2
                              ? ElevatedButton(
                                  onPressed: () {
                                    onButtonPressed(context);
                                  },
                                  child: const Text('Start Shopping'))
                              : TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Skip To The App',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnBoardPage extends StatelessWidget {
  final Column? boardColumn;

  const OnBoardPage({super.key, required this.boardColumn});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 130,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
        ),
        Container(
          color: Colors.orange,
          child: Center(child: boardColumn),
        ),
      ],
    );
  }
}
