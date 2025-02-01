import 'package:carro_weddings_ag/container_images.dart';
import 'package:carro_weddings_ag/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String? _gender;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); 

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userName', _name);
      prefs.setString('userGender', _gender!);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLandscape = constraints.maxWidth > constraints.maxHeight;
          return Container(
            padding: EdgeInsets.only(bottom: isLandscape ? 40 : 80),
            color: Colors.white,
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2;
                });
              },
              children: [
                // First Page 
                buildImageContainer(
                  Colors.white,
                  'Discover stunning wedding venues..',
                  'Your perfect day deserves the perfect setting. Explore a handpicked collection of exquisite wedding venues, from charming countryside estates to elegant urban spaces.',
                 // 'assets/images/grand_villa_heights/448758938_1003793968416901_2552688706935637892_n.jpg'
                  'assets/images/grand_villa_heights/9.jpg'
                ),

                // Second Page
                buildImageContainer(
                  Colors.white,
                  'Compare packages..',
                  'Every couple is unique, and so should be your wedding experience. Dive into detailed packages that suit a variety of needs, from intimate gatherings to grand celebrations.',
                  //'assets/images/le_petit_chateau/366553845_783067267156240_6812344536075950937_n.jpg'
                  'assets/images/the_croft/433438235_940669148062717_5543197063631213252_n.jpg'
                ),

                // Last Page with Form
                Stack(
                  children: [
                    buildImageContainer(
                      Colors.white,
                      'Book and plan with ease..',
                      'Simplify your wedding planning journey and choose the best deal that fits your budget',
                      'assets/images/runa_farm/onboarding_2.jpg'
                    ),
                    Positioned(
                      left: 15,
                      right: 15,
                      bottom: 45,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Name field
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Enter your name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _name = value!;
                              },
                            ),
                            const SizedBox(height: 10),

                            // Gender field (using DropdownButton for selection)
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Select your gender',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2.5), 
                                ),
                              ), 
                              value: _gender,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                              items: ['Male', 'Female', 'Other']
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your gender';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8, width: 5,),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: isLastPage
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                   backgroundColor: Colors.black, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                   // backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(65)),
                onPressed: _submitForm,
                child: const Text(
                  "Get Started",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              height: 70,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                      onPressed: () {
                        controller.jumpToPage(2);
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),

                  // Smooth Page Indicator
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const WormEffect(
                      spacing: 15,
                      dotColor: Colors.blueGrey,
                      activeDotColor: Colors.black,
                    ),
                    onDotClicked: (index) {
                      controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),

                  // Next Button
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut);
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )),
                ],
              ),
            ),
    );
  }
}