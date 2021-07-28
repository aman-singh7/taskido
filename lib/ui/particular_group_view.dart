import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/particular_group_viewmodel.dart';

class ParticularGroupView extends StatelessWidget {
  static const id = 'particular_group_view';
  final argument = Get.arguments;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return BaseView<ParticularGroupViewModel>(
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                argument.name,
                overflow: TextOverflow.ellipsis,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_today),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.info_outline),
                ),
              ],
            ),
            body: Stack(
              children: [
                Positioned(
                  bottom: h / 40,
                  left: w / 22,
                  child: Container(
                    height: h / 10,
                    width: w / 7,
                    child: MaterialButton(
                      color: Colors.amber,
                      shape: CircleBorder(),
                      onPressed: () {},
                      child: Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (argument.isAdmin) ...[
                  Positioned(
                    bottom: h / 40,
                    right: w / 22,
                    child: Container(
                      height: h / 10,
                      width: w / 7,
                      child: MaterialButton(
                        shape: CircleBorder(),
                        color: Colors.red,
                        onPressed: () {},
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
