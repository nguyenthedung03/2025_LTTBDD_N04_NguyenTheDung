import 'package:flutter/material.dart';
import 'package:rentcar_app/bloc/state_bloc.dart';
import 'package:rentcar_app/bloc/state_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../model/car.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController =
      TextEditingController();
  String _query = '';
  int _selectedCategory =
      0; // 0: Tất cả, 1: Phổ biến, 2: Mới nhất, 3: Sang trọng

  List<Car> get _filteredCars {
    // First, apply category filter
    List<Car> categoryFiltered =
        _carsForSelected();

    // Then apply search filter if needed
    if (_query.trim().isEmpty)
      return categoryFiltered;

    final q = _query.toLowerCase();
    return categoryFiltered.where((c) {
      return c.companyName
              .toLowerCase()
              .contains(q) ||
          c.carName.toLowerCase().contains(q) ||
          c.price.toString().contains(q);
    }).toList();
  }

  List<Car> _carsForSelected() {
    List<Car> list = List.from(carList.cars);
    switch (_selectedCategory) {
      case 1: // Phổ biến: sort by price desc as a proxy for popularity
        list.sort(
            (a, b) => b.price.compareTo(a.price));
        return list;
      case 2: // Mới nhất: show reversed list (assume later entries are newer)
        return list.reversed.toList();
      case 3: // Sang trọng: price threshold
        return list
            .where((c) => c.price >= 2500)
            .toList();
      case 0:
      default:
        return list;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Consumer<StateProvider>(
            builder: (context, state, _) {
          return ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(state.loggedIn
                    ? (state.userName ?? '')
                    : 'Khách'),
                accountEmail: Text(state.loggedIn
                    ? (state.userEmail ?? '')
                    : 'Chưa đăng nhập'),
                currentAccountPicture:
                    CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(state.loggedIn
                      ? (state.userName ?? 'U')[0]
                          .toUpperCase()
                      : 'G'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Đăng nhập'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, '/login');
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.app_registration),
                title: Text('Đăng ký'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, '/register');
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Xe đã thích'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, '/favorites');
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Đăng xuất'),
                onTap: () {
                  Provider.of<StateProvider>(
                          context,
                          listen: false)
                      .logout();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }),
      ),
      appBar: AppBar(
        title: Text(
          'Thuê Xe',
          style:
              TextStyle(color: Colors.pinkAccent),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_outline,
              color: Colors.pinkAccent,
            ),
            onPressed: () {
              // open drawer to show account actions
              Scaffold.of(context).openDrawer();
            },
          )
        ],
      ),
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            _buildCategories(),
            _buildPopularCars(),
            _buildSpecialOffers(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      'Tất cả',
      'Phổ biến',
      'Mới nhất',
      'Sang trọng'
    ];
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = index;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 8),
              padding: EdgeInsets.symmetric(
                  horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: index == _selectedCategory
                    ? Colors.pinkAccent
                    : Colors.transparent,
                borderRadius:
                    BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.pinkAccent,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color:
                        index == _selectedCategory
                            ? Colors.white
                            : Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(16),
      padding:
          EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (v) =>
            setState(() => _query = v),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search,
              color: Colors.pinkAccent),
          hintText: 'Tìm kiếm xe...',
          hintStyle:
              TextStyle(color: Colors.white70),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear,
                      color: Colors.white70),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _query = '';
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildPopularCars() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _selectedCategory == 0
                ? 'Tất cả xe'
                : _selectedCategory == 1
                    ? 'Xe phổ biến'
                    : _selectedCategory == 2
                        ? 'Mới nhất'
                        : 'Sang trọng',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _filteredCars.length,
            itemBuilder: (context, index) {
              final car = _filteredCars[index];
              return GestureDetector(
                onTap: () {
                  Provider.of<StateProvider>(
                          context,
                          listen: false)
                      .setCurrentCar(car);
                  // Navigate to specific car detail page based on car type
                  final name =
                      car.carName.toLowerCase();
                  final company = car.companyName
                      .toLowerCase();
                  if (name.contains('corvette') ||
                      company.contains(
                          'chevrolet')) {
                    Navigator.pushNamed(
                        context, '/car_corvette');
                  } else if (company.contains(
                          'lamborghini') ||
                      name.contains(
                          'aventador')) {
                    Navigator.pushNamed(
                        context, '/car_lambo');
                  } else {
                    Navigator.pushNamed(
                        context, '/car');
                  }
                },
                child: Container(
                  width: 300,
                  margin: EdgeInsets.symmetric(
                      horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius
                                  .circular(20),
                          child: Image.asset(
                            'assets/${car.imgList[0]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding:
                              EdgeInsets.all(16),
                          decoration:
                              BoxDecoration(
                            gradient:
                                LinearGradient(
                              begin: Alignment
                                  .bottomCenter,
                              end: Alignment
                                  .topCenter,
                              colors: [
                                Colors.black
                                    .withOpacity(
                                        0.8),
                                Colors
                                    .transparent,
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                '${car.companyName} ${car.carName}',
                                style: TextStyle(
                                  color: Colors
                                      .white,
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${car.price}\$ / ngày',
                                style: TextStyle(
                                  color: Colors
                                      .pinkAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialOffers() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Ưu đãi đặc biệt',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.deepPurpleAccent
              ],
            ),
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Giảm 15%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Cho lần đặt xe đầu tiên',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  'Đặt ngay',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
