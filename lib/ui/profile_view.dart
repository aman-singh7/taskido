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
      builder: (context, model, child) => Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: ProfileClipper(),
                child: Container(
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
              Container(
                color: Color.fromRGBO(255, 255, 255, 0.19),
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
                        'Anand ',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Text(
                      'anand_k@cs.iitr.ac.in',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -h * 4,
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
