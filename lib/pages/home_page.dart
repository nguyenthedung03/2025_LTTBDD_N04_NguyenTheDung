import 'package:flutter/material.dart';
import 'package:rentcar_app/bloc/state_bloc.dart';
import 'package:rentcar_app/bloc/state_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../model/car.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thuê Xe',
          style:
              TextStyle(color: Colors.pinkAccent),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.pinkAccent,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_outline,
              color: Colors.pinkAccent,
            ),
            onPressed: () {},
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
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search,
              color: Colors.pinkAccent),
          hintText: 'Tìm kiếm xe...',
          hintStyle:
              TextStyle(color: Colors.white70),
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
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: 8),
            padding: EdgeInsets.symmetric(
                horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: index == 0
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
                  color: index == 0
                      ? Colors.white
                      : Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
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
            'Xe phổ biến',
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
            itemCount: carList.cars.length,
            itemBuilder: (context, index) {
              final car = carList.cars[index];
              return GestureDetector(
                onTap: () {
                  currentCar = carList.cars[index];
                  Navigator.pushNamed(context, '/car');
                },
                child: Container(
                  width: 300,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(
                                20),
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
                        decoration: BoxDecoration(
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
                              Colors.transparent,
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
                                color:
                                    Colors.white,
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
