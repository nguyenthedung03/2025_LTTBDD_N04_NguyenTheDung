import 'package:flutter/material.dart';

double iconSize = 30;

CarList carList = CarList(cars: [
  Car(
      companyName: "Chevrolet",
      carName: "Corvette C8",
      price: 15000000,
      imgList: [
        "corvette_front.png",
        "corvette_back.png",
        "interior1.png",
        "interior2.png",
        "corvette_front2.png",
      ],
      offerDetails: [
        {
          Icon(Icons.settings, size: iconSize):
              "Số tự động 8 cấp"
        },
        {
          Icon(
              Icons.airline_seat_individual_suite,
              size: iconSize): "2 chỗ ngồi"
        },
        {
          Icon(Icons.local_gas_station,
              size: iconSize): "Động cơ V8 6.2L"
        },
        {
          Icon(Icons.speed, size: iconSize):
              "495 mã lực"
        },
        {
          Icon(Icons.palette, size: iconSize):
              "12 màu sắc"
        },
      ],
      specifications: [
        {
          Icon(Icons.local_gas_station,
              size: iconSize): {
            "Động cơ": "6.2L V8"
          }
        },
        {
          Icon(Icons.speed, size: iconSize): {
            "Max": "312km/h"
          }
        },
        {
          Icon(Icons.power, size: iconSize): {
            "HP": "495"
          }
        },
        {
          Icon(Icons.sync, size: iconSize): {
            "NM": "637"
          }
        },
        {
          Icon(Icons.timer, size: iconSize): {
            "0-100": "2.9s"
          }
        },
      ],
      features: [
        {
          Icon(Icons.bluetooth, size: iconSize):
              "BT 5.0"
        },
        {
          Icon(Icons.speaker, size: iconSize):
              "Bose 14 loa"
        },
        {
          Icon(Icons.security, size: iconSize):
              "Smartkey"
        },
        {
          Icon(Icons.phone_android,
              size: iconSize): "CarPlay/Android"
        },
        {
          Icon(Icons.ac_unit, size: iconSize):
              "2 vùng A/C"
        },
      ]),
  Car(
      companyName: "Lamborghini",
      carName: "Aventador SVJ",
      price: 25000000,
      imgList: [
        "lambo_front.png",
        "interior_lambo.png",
        "lambo_back.png",
      ],
      offerDetails: [
        {
          Icon(Icons.settings, size: iconSize):
              "Số tự động 7 cấp ISR"
        },
        {
          Icon(
              Icons.airline_seat_individual_suite,
              size: iconSize): "2 chỗ ngồi"
        },
        {
          Icon(Icons.local_gas_station,
              size: iconSize): "Động cơ V12 6.5L"
        },
        {
          Icon(Icons.speed, size: iconSize):
              "770 mã lực"
        },
        {
          Icon(Icons.palette, size: iconSize):
              "Tùy chọn màu không giới hạn"
        },
      ],
      specifications: [
        {
          Icon(Icons.timer, size: iconSize): {
            "0-100 km/h": "2.8 giây"
          }
        },
        {
          Icon(Icons.speed, size: iconSize): {
            "Tốc độ tối đa": "350+ km/h"
          }
        },
        {
          Icon(Icons.local_gas_station,
              size: iconSize): {
            "Động cơ": "V12 6.5L"
          }
        },
        {
          Icon(Icons.power, size: iconSize): {
            "Công suất": "770 mã lực"
          }
        },
        {
          Icon(Icons.sync, size: iconSize): {
            "Mô-men xoắn": "720 Nm"
          }
        },
      ],
      features: [
        {
          Icon(Icons.navigation, size: iconSize):
              "ALA 2.0"
        },
        {
          Icon(Icons.settings_input_component,
              size: iconSize): "Mag Ride"
        },
        {
          Icon(Icons.security, size: iconSize):
              "Smartkey"
        },
        {
          Icon(Icons.surround_sound,
              size: iconSize): "Sensonum"
        },
        {
          Icon(Icons.ac_unit, size: iconSize):
              "Auto A/C"
        },
      ]),
  Car(
      companyName: "Ferrari",
      carName: "SF90 Stradale",
      price: 30000000,
      imgList: [
        "ferrari_front.png",
        "ferrari_back.png",
        "ferrari_interior.png",
      ],
      offerDetails: [
        {
          Icon(Icons.settings, size: iconSize):
              "Số tự động 8 cấp DCT"
        },
        {
          Icon(
              Icons.airline_seat_individual_suite,
              size: iconSize): "2 chỗ ngồi"
        },
        {
          Icon(Icons.battery_charging_full,
              size: iconSize): "PHEV Hybrid"
        },
        {
          Icon(Icons.speed, size: iconSize):
              "1000 mã lực"
        },
        {
          Icon(Icons.palette, size: iconSize):
              "Tùy chọn màu cá nhân hóa"
        },
      ],
      specifications: [
        {
          Icon(Icons.timer, size: iconSize): {
            "0-100 km/h": "2.5 giây"
          }
        },
        {
          Icon(Icons.speed, size: iconSize): {
            "Tốc độ tối đa": "340 km/h"
          }
        },
        {
          Icon(Icons.local_gas_station,
              size: iconSize): {
            "Động cơ": "V8 4.0L + 3 mô-tơ điện"
          }
        },
        {
          Icon(Icons.power, size: iconSize): {
            "Công suất tổng": "1000 mã lực"
          }
        },
        {
          Icon(Icons.battery_charging_full,
              size: iconSize): {
            "Phạm vi điện": "25 km"
          }
        },
      ],
      features: [
        {
          Icon(Icons.touch_app, size: iconSize):
              "Touch 16\""
        },
        {
          Icon(Icons.battery_charging_full,
              size: iconSize): "EV Mode"
        },
        {
          Icon(Icons.security, size: iconSize):
              "Active Safety"
        },
        {
          Icon(Icons.speed, size: iconSize):
              "Qualify Mode"
        },
        {
          Icon(Icons.ac_unit, size: iconSize):
              "2 vùng A/C"
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
