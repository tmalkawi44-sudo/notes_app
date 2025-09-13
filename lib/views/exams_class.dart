import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:notes_app/widgets/exams_container.dart';

class ExamsClass extends StatelessWidget {
  const ExamsClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: SvgPicture.asset('lib/icons/background ( all logos ).svg'),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xff546068)),
                        bottom: BorderSide(color: Color(0xff546068)),
                        right: BorderSide(color: Color(0xff546068)),
                        left: BorderSide(color: Color(0xff546068)),
                      ),
                      color: Color(0xffcfdbeb).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ExamsContainer(
                      title: 'First exam',
                      color: Color(0xffdde7f3),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xff546068)),
                        bottom: BorderSide(color: Color(0xff546068)),
                        right: BorderSide(color: Color(0xff546068)),
                        left: BorderSide(color: Color(0xff546068)),
                      ),
                      color: Color(0xffd9e6e4).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ExamsContainer(
                      title: 'Midterm exam',
                      color: Color(0xffd9e6e4).withOpacity(0.7),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xff546068)),
                        bottom: BorderSide(color: Color(0xff546068)),
                        right: BorderSide(color: Color(0xff546068)),
                        left: BorderSide(color: Color(0xff546068)),
                      ),
                      color: Color(0xffcfdbeb).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ExamsContainer(
                      title: 'Second exam',
                      color: Color(0xffdde7f3),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Color(0xff546068)),
                        bottom: BorderSide(color: Color(0xff546068)),
                        right: BorderSide(color: Color(0xff546068)),
                        left: BorderSide(color: Color(0xff546068)),
                      ),
                      color: Color(0xffd9e6e4).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(35),
                    ),

                    child: ExamsContainer(
                      title: 'Final exam',
                      color: Color(0xffd9e6e4).withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
