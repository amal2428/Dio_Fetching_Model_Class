import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio_fetching_model_class/constants/constants.dart';
import 'package:dio_fetching_model_class/model/response_model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? movieTitle;
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("dio fetching model class"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(movieTitle ?? 'Click the button to fetch data'),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: const Icon(
                Icons.done_outline_sharp,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      final response = await dio.get(pathUrl);
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        ResponseModel jsonObject = ResponseModel.fromJson(response.data);
        int randomMovieLength = Random().nextInt(jsonObject.results.length);

        setState(() {
          movieTitle = jsonObject.results[randomMovieLength].originalTitle;
          print(movieTitle);
        });
      } else {
        print("Server side error");
      }
    } catch (e) {
      print("client side error");
    }
  }
}
