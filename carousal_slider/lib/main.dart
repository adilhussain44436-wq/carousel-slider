import 'package:carousal_slider/images.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SliderScreen(),
    );
  }
}

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  // Carousel ko buttons ke zariye control karne ke liye controller
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        leading: const Icon(Icons.menu),
        title: const Text(
          "Carousel Slider",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Stack: Slider aur Buttons ko ek doosre ke upar rakhne ke liye
            Stack(
              alignment: Alignment.center,
              children: [
                // 1. Carousel Slider widget
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: Images.images.length,
                  options: CarouselOptions(
                    height: 450,
                    viewportFraction:
                        1.0, // Puri screen par ek hi image dikhegi
                    enableInfiniteScroll:
                        false, // Aakhri image ke baad loop nahi hoga
                    autoPlay:
                        false, // Khud se slide nahi hoga, buttons ke zariye hoga
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final image = Images.images[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.pause_circle, color: Colors.black),
                      onPressed: () {
                        _carouselController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ),

                // 2. Left Button (Previous Image)
                Positioned(
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        _carouselController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ),

                // 3. Right Button (Next Image)
                Positioned(
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),

                      onPressed: () {
                        _carouselController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
