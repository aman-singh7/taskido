import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_dot_do/ui/base_view.dart';
import 'package:task_dot_do/viewmodels/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 360;
    var w = MediaQuery.of(context).size.width / 360;
    return BaseView<ProfileViewModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(0),
                height: h * 450,
                width: w * 360,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/Group5.jpg',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              ClipPath(
                clipper: ProfileClipper(),
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  height: h * 180,
                  width: w * 360,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/profile_background_image.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: h * 50,
                left: w * 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        model.person.name,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Text(
                      model.person.email,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: h * 120,
                left: w * 25,
                child: Material(
                  shape: CircleBorder(),
                  elevation: 10,
                  color: Colors.transparent,
                  shadowColor: Colors.black54,
                  clipBehavior: Clip.antiAlias,
                  child: SvgPicture.asset('assets/images/profile_icon.svg'),
                ),
              ),
              Positioned(
                top: h * 220,
                child: Container(
                  width: w * 360,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            leading: Icon(Icons.cast_for_education),
                            title: Text(model.person.enrollment),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            leading: Icon(Icons.phone),
                            title: Text(model.person.phone),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height / 1.1);
    path.lineTo(size.width, size.height / 1.7);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
