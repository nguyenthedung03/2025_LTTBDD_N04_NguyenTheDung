import 'package:flutter/material.dart';

double iconSize = 30;

CarList carList = CarList(cars: [
  Car(
      companyName: "Chevrolet",
      carName: "Corvette",
      price: 2100,
      imgList: [
        "corvette_front.png",
        "corvette_back.png",
        "interior1.png",
        "interior2.png",
        "corvette_front2.png",
      ],
      offerDetails: [
        {
          Icon(Icons.bluetooth, size: iconSize):
              "Tự động"
        },
        {
          Icon(
              Icons.airline_seat_individual_suite,
              size: iconSize): "4 chỗ ngồi"
        },
        {
          Icon(Icons.pin_drop, size: iconSize):
              "6.4L"
        },
        {
          Icon(Icons.shutter_speed,
              size: iconSize): "5HP"
        },
        {
          Icon(Icons.invert_colors,
              size: iconSize): "Nhiều màu sắc"
        },
      ],
      specifications: [
        {
          Icon(Icons.timeline, size: iconSize): {
            "Giá niêm yết": "₹ 40.8 - 49.2 Lakh"
          }
        },
        {
          Icon(Icons.power, size: iconSize): {
            "Động cơ (tối đa)": "3996 cc"
          }
        },
        {
          Icon(Icons.assignment_late,
              size: iconSize): {"BHP": "700"}
        },
        {
          Icon(Icons.account_balance_wallet,
              size: iconSize): {
            "Thông số khác": "14.2 kmpl"
          }
        },
        {
          Icon(Icons.cached, size: iconSize): {
            "Thông số khác": "14.2 kmpl"
          }
        },
      ],
      features: [
        {
          Icon(Icons.bluetooth, size: iconSize):
              "Bluetooth"
        },
        {
          Icon(Icons.usb, size: iconSize):
              "Cổng USB"
        },
        {
          Icon(Icons.power_settings_new,
              size: iconSize): "Khóa không chìa"
        },
        {
          Icon(Icons.android, size: iconSize):
              "Android Auto"
        },
        {
          Icon(Icons.ac_unit, size: iconSize):
              "AC"
        },
      ]),
  Car(
      companyName: "Lamborghini",
      carName: "Aventador",
      price: 3000,
      imgList: [
        "lambo_front.png",
        "interior_lambo.png",
        "lambo_back.png",
      ],
      offerDetails: [
        {
          Icon(Icons.bluetooth, size: iconSize):
              "Automatic"
        },
        {
          Icon(Icons.bluetooth, size: iconSize):
              "4 chỗ ngồi"
        },
        {
          Icon(Icons.bluetooth, size: iconSize):
              "6.4L"
        },
        {
          Icon(Icons.bluetooth, size: iconSize):
              "5HP"
        },
        {
          Icon(Icons.bluetooth, size: iconSize):
              "Nhiều màu sắc"
        },
      ],
      specifications: [
        {
          Icon(Icons.bluetooth, size: iconSize): {
            "Milegp(upto)": "14.2 kmpl"
          }
        },
        {
          Icon(Icons.bluetooth, size: iconSize): {
            "Engine(upto)": "3996 cc"
          }
        },
        {
          Icon(Icons.bluetooth, size: iconSize): {
            "BHP": "700"
          }
        },
        {
          Icon(Icons.bluetooth, size: iconSize): {
            "Milegp(upto)": "14.2 kmpl"
          }
        },
        {
          Icon(Icons.bluetooth, size: iconSize): {
            "Milegp(upto)": "14.2 kmpl"
          }
        },
      ],
      features: [
        {
          Icon(Icons.bluetooth, size: iconSize):
              "Bluetooth"
        },
        {
          Icon(Icons.bluetooth, size: iconSize):
              "Cổng USB"
        },
        {
          Icon(Icons.bluetooth, size: iconSize):
              "Không cần chìa khóa"
        },
        {
          Icon(Icons.bluetooth, size: iconSize):
              "Android Auto"
        },
        {
          Icon(Icons.bluetooth, size: iconSize):
              "Điều hòa"
        },
      ])
]);

class CarList {
  List<Car> cars;

  CarList({
    required this.cars,
  });
}

class Car {
  String companyName;
  String carName;
  int price;
  List<String> imgList;
  List<Map<Icon, String>> offerDetails;
  List<Map<Icon, String>> features;
  List<Map<Icon, Map<String, String>>>
      specifications;

  Car({
    required this.companyName,
    required this.carName,
    required this.price,
    required this.imgList,
    required this.offerDetails,
    required this.features,
    required this.specifications,
  });
}
