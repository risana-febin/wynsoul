import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project/fav.dart';
import 'package:project/placecard.dart';
import 'package:project/profil.dart';
import 'package:project/video.dart';
import 'package:project/mainpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> carouselImages = [
    'https://tripinic.com/wp-content/uploads/2024/05/En-Ooru-Tribal-Heritage-Village.jpg',
    "https://www.trawell.in/admin/images/upload/049130561MeenmuttyFalls_Main.jpg",
    "https://indiano.travel/wp-content/uploads/2024/11/Kurumbalakotta-Mala.jpg",
    "https://www.dtpcwayanad.com/uploads/picture_gallery/gallery_images/banasura-sagar-dam-wayanad-43-20230429183921377875.webp",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            const Icon(Icons.forest, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              'Wynsoul',
              style: GoogleFonts.pacifico(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Fav(favorites: [])),
              );
            },
            icon: const Icon(Icons.favorite, color: Colors.red),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Profile()),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VideoExample(),

                const SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      placeCard(
                        "Karappuzha Dam",
                        "https://wayanadtourism.co.in/images/places-to-visit/headers/karapuzha-dam-wayanad-header-wayanad-tourism.jpg.jpg",
                      ),
                      placeCard(
                        "Kuruva",
                        "https://wayanadtourism.co.in/images/places-to-visit/headers/kuruva-island-wayanad-tourism-entry-fee-timings-holidays-reviews-header.jpg",
                      ),
                      placeCard(
                        "Meenmutty Waterfalls",
                        "https://trip2kerala.com/wp-content/uploads/2022/01/meenmutty_waterfall_thir.jpg",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tourist Places",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        final mainState = context
                            .findAncestorStateOfType<MainScreenState>();
                        mainState?.onItemTapped(1);
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                CarouselSlider(
                  items: carouselImages
                      .map(
                        (imageUrl) => ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 16 / 9,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
