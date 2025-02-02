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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      backgroundColor: Colors.blueGrey[200], 
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 30, 
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select your gender',
                  border: OutlineInputBorder(),
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
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
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
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            isLastPage = index == 2;
          });
        },
        children: [
          buildImageContainer(
            Colors.white,
            'Discover stunning wedding venues..',
            'Your perfect day deserves the perfect setting. Explore a handpicked collection of exquisite wedding venues.',
            'assets/images/grand_villa_heights/9.jpg',
          ),
          buildImageContainer(
            Colors.white,
            'Compare packages..',
            'Every couple is unique, and so should be your wedding experience.',
            'assets/images/the_croft/433438235_940669148062717_5543197063631213252_n.jpg',
          ),
          buildImageContainer(
            Colors.white,
            'Book and plan with ease..',
            'Simplify your wedding planning journey and choose the best deal that fits your budget.',
            'assets/images/runa_farm/onboarding_2.jpg',
          ),
        ],
      ),
      bottomSheet: Container(
      color: Colors.white, 
      child: isLastPage
      ? Padding(
          padding: const EdgeInsets.all(35.0),
          child: SizedBox(
            width: double.infinity, 
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                minimumSize: const Size.fromHeight(60),
              ),
              onPressed: () => _showBottomSheet(context),
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
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
              TextButton(
                onPressed: () => controller.jumpToPage(2),
                child: const Text("Skip",
                    style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
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
              TextButton(
                onPressed: () => controller.nextPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                ),
                child: const Text("Next",
                    style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ],
          ),
        ),
     )
  );
 }
}