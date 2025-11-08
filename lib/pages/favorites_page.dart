import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/state_provider.dart';
import '../model/car.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state =
        Provider.of<StateProvider>(context);
    final List<Car> favs =
        state.getFavoriteCars();

    return Scaffold(
      appBar: AppBar(title: Text('Xe đã thích')),
      body: favs.isEmpty
          ? Center(
              child: Text(
                  'Chưa có xe nào trong danh sách yêu thích'))
          : ListView.builder(
              itemCount: favs.length,
              itemBuilder: (context, index) {
                final car = favs[index];
                return ListTile(
                  leading: Image.asset(
                      'assets/${car.imgList[0]}',
                      width: 64,
                      fit: BoxFit.cover),
                  title: Text(
                      '${car.companyName} ${car.carName}'),
                  subtitle: Text(
                      '${car.price}\$ / ngày'),
                  trailing: IconButton(
                    icon:
                        Icon(Icons.chevron_right),
                    onPressed: () {
                      state.setCurrentCar(car);
                      Navigator.pushNamed(
                          context, '/car');
                    },
                  ),
                );
              },
            ),
    );
  }
}
