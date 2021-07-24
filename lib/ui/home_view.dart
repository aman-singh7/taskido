import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 360;

    List<Widget> _buildDateTile(dynamic model) {
      var _date, result = <Widget>[], dates;
      dates = model.dates;
      for (_date in dates) {
        result.add(
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white60),
              elevation: MaterialStateProperty.all<double>(2.0),
              overlayColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 15.0, 2.0, 15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      _date.date.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    _date.day.substring(0, 3),
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return result;
    }

    return BaseView<HomeViewModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                'Home',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              child: Container(
                height: h * 20,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: '\t' * 6 + 'Search Tasks',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _buildDateTile(model),
            ),
            Stack(
              children: [
                SvgPicture.asset('assets/images/background_image.svg'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
