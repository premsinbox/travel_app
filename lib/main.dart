import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sample_screen/Pages/inbox.dart';
import 'package:sample_screen/Pages/profile.dart';
import 'package:sample_screen/Pages/saved.dart';
import 'package:sample_screen/Pages/trip.dart';

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'BeVietnamPro'),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = true;

  final List<Widget> _pages = [
    ExplorePage(),
    SavedPage(),
    InboxPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isVisible) {
        setState(() {
          _isVisible = false;
        });
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            _buildCurrentPage(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: _buildBottomNavigationBar(),
              ),
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TripPage()),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5A5F),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 30),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Trip',
                        style: TextStyle(
                          color: const Color(0xFF686868),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPage() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollUpdateNotification) {
          _onScroll();
        }
        return true;
      },
      child: _pages[_selectedIndex],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.search, "Explore", 0),
          _buildNavItem(Icons.favorite_outline, "Saved", 1),
          SizedBox(width: 60),
          _buildNavItem(Icons.message_outlined, "Inbox", 2),
          _buildNavItem(Icons.person_outline, "Profile", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? const Color(0xFFFF5A5F) : const Color(0xFF686868),
            size: 30,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? const Color(0xFFFF5A5F) : const Color(0xFF686868),
              fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// //Dummypage
// class DummyPage extends StatelessWidget {
//   final String title;

//   DummyPage(this.title);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: List.generate(20, (index) => 
//           ListTile(
//             title: Text('$title Item $index'),
//           )
//         ),
//       ),
//     );
//   }
// }


//Explorepage
class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopContainer(),
          SizedBox(height: 20),
          _buildPopularLocations(),
          SizedBox(height: 16),
          _buildRecommendedSection(),
          SizedBox(height: 35),
          _buildAd(),
          SizedBox(height: 35),
          _buildMostViewed(),
        ],
      ),
    );
  }
  

  // Top Section (with status bar)
  Widget _buildTopContainer() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 15), 
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 236, 249),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
  'Explore the world! By',
  style: TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontFamily: 'BeVietnamPro', 
    fontWeight: FontWeight.w700,
  ),
),

          SizedBox(height: 1),
          Text(
  'Travelling',
  style: TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontFamily: 'BeVietnamPro',
    fontWeight: FontWeight.w700, 
  ),
),
 SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child:TextField(
  decoration: InputDecoration(
    hintText: 'Where did you go?',
    hintStyle: TextStyle(
      fontFamily: 'BeVietnamPro', 
      fontSize: 14, 
    ),
    filled: true,
    fillColor: Colors.white,
    prefixIcon: Container(
      padding: EdgeInsets.all(12), 
      child: Image.asset(
        'assets/images/search.png', 
        fit: BoxFit.contain,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    ),
  ),
),

              ),
              SizedBox(width: 8),
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Image.asset('assets/images/filter.png')

              )
            ],
          )
        ],
      ),
    );
  }

  // Popular Locations Section
  Widget _buildPopularLocations() {
  final locations = [
    {'name': 'India', 'image': 'assets/images/india.jpeg'},
    {'name': 'Moscow', 'image': 'assets/images/moscow.jpeg'},
    {'name': 'USA', 'image': 'assets/images/usa.jpg'},
    {'name': 'Japan', 'image': 'assets/images/japan.jpeg'},
    {'name': 'Brazil', 'image': 'assets/images/brazil.jpeg'},
    {'name': 'France', 'image': 'assets/images/france.jpeg'},
        {'name': 'Thailand', 'image': 'assets/images/thailand.png'},
    {'name': 'Sri Lanka', 'image': 'assets/images/srilanka.jpeg'},
    {'name': 'Dubai', 'image': 'assets/images/dubai.jpeg'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text('Popular locations', style: TextStyle(
    color: Colors.black,
    fontSize: 22,
    fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600, 
  ),),
      ),
      SizedBox(height: 12),
      Container(
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return _buildLocationCard(locations[index]['name']!, locations[index]['image']!);
          },
        ),
      ),
    ],
  );
}

//LocationCard
  Widget _buildLocationCard(String location, String imageUrl) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(imageUrl, height: 158, width: 150, fit: BoxFit.cover),
              ),
              
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      location,
                     style: TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'BeVietnamPro', 
    fontWeight: FontWeight.w200, 
  ),),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

// Recommended Section
Widget _buildRecommendedSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'Recommended',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'BeVietnamPro',
            fontWeight: FontWeight.w600, // Set semi-bold weight
          ),
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(recommendedItems.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: _buildRecommendedCard(
                  recommendedItems[index]['image']!,
                  recommendedItems[index]['price']!,
                  recommendedItems[index]['name']!,
                  recommendedItems[index]['description']!,
                  recommendedItems[index]['rating']!,
                ),
              );
            }),
          ),
        ),
      ),
    ],
  );
}

// Sample data for recommended items
final List<Map<String, String>> recommendedItems = [
  {
    'image': 'assets/images/hotel1.jpeg',
    'price': '\$120',
    'name': 'Carinthia Lake see Breakfast',
    'description': 'Private room / 4 beds',
    'rating': '4',
  },
  {
    'image': 'assets/images/hotel2.jpeg',
    'price': '\$400',
    'name': 'Beachside Villa',
    'description': 'Private room / 2 beds',
    'rating': '5',
  },
  {
    'image': 'assets/images/hotel5.jpeg',
    'price': '\$180',
    'name': 'Mountain Retreat',
    'description': 'Shared room / 6 beds',
    'rating': '4',
  },
  {
    'image': 'assets/images/hotel4.jpg',
    'price': '\$220',
    'name': 'City Center Inn',
    'description': 'Private room / 1 bed',
    'rating': '3',
  },
];

//Recommended Card
Widget _buildRecommendedCard(
  String imageUrl,
  String price,
  String name,
  String description,
  String rating,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imageUrl, height: 150, width: 230, fit: BoxFit.cover),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Icon(Icons.favorite, color: Colors.grey),
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '$price ',style: TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'BeVietnamPro',     fontWeight: FontWeight.w600, 
  ),),
                TextSpan(text: '/ Night', style: TextStyle(
    color: Colors.black,
    fontSize: 13,
    fontFamily: 'BeVietnamPro', 
    fontWeight: FontWeight.w600, 
    
  ),),
              ],
            ),
          ),
          Row(
            
           mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              SizedBox(width:3),
              Image.asset('assets/images/thunder.png'),
              SizedBox(width: 100),
              Icon(Icons.star, color: Colors.red, size: 18),
             
              Text(rating, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
      SizedBox(height: 4),
      Text(name, style: TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'BeVietnamPro', 
    fontWeight: FontWeight.w500, 
  ),),
      Text(description,style: TextStyle(
    color: const Color(0xFF686868),
    fontSize: 14,
    fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
  ),),
    ],
  );
}

  // Ad Section
  Widget _buildAd() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17.0),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Group 12211@3x.png'),  
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hosting Fee for', style: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600, 
  ),),
            Text('as low as 1%', style: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w600, 
  ),),
            SizedBox(height: 20),
            Container(
              height: 35,
              width: 140,
              decoration: BoxDecoration(
                color: const Color(0xFFFF5A5F),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text('Become a Host',style: TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontFamily: 'BeVietnamPro', fontWeight: FontWeight.w400,
  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sample data for most viewed hotels
  final List<Map<String, String>> mostViewedItems = [
    {
      'image': 'assets/images/hotel6.jpeg',
      'price': '\$240',
      'name': 'Carinthia Lake',
      'description': 'Private room / 4 beds',
      'rating': '4',
    },
    {
      'image': 'assets/images/hotel3.jpeg',
      'price': '\$180',
      'name': 'Mountain Lodge',
      'description': 'Shared room / 6 beds',
      'rating': '4',
    },
    {
      'image': 'assets/images/hotel7.jpg',
      'price': '\$300',
      'name': 'Ocean View Suite',
      'description': 'Private room / 2 beds',
      'rating': '5',
    },
    {
      'image': 'assets/images/hotel8.jpeg',
      'price': '\$220',
      'name': 'City Center Hotel',
      'description': 'Private room / 1 bed',
      'rating': '3',
    },
  ];

  // Most Viewed Section
  Widget _buildMostViewed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Most Viewed',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w600, 
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical, 
            child: Column(
              children: List.generate(mostViewedItems.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildMostviewedCard(
                    mostViewedItems[index]['image']!,
                    mostViewedItems[index]['price']!,
                    mostViewedItems[index]['name']!,
                    mostViewedItems[index]['description']!,
                    mostViewedItems[index]['rating']!,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMostviewedCard(
    String imageUrl,
    String price,
    String name,
    String description,
    String rating,
  ) {
    return Container(
      width: double.infinity, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover), 
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: Icon(Icons.favorite, color: Colors.grey),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
  children: [
    RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: price,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w800, 
            ),
          ),
          TextSpan(
            text: ' / Night',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w700,
              
            ),
          ),
        ],
      ),
    ),
     Image.asset(
      'assets/images/thunder.png',
      height: 20, 
      width: 20,  
    ),
  ],
),
  
              
              Row(
                children: [
                  Icon(Icons.star, color: const Color(0xFFFF5A5F), size: 20),
                  Text(rating, style: TextStyle(color: Colors.black)),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(name,  style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w500, 
              
            ),),
          Text(description, style: TextStyle(
              color: const Color(0xFF686868),
              fontSize: 18,
              fontFamily: 'BeVietnamPro',
              fontWeight: FontWeight.w400,
            ),),
        ],
      ),
    );
  }

 }


