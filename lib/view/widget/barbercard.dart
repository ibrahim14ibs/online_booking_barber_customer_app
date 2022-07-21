import 'package:barber/view/details.dart';
import 'package:flutter/material.dart';

class BarberCard extends StatelessWidget {
  const BarberCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: Color(0XffEDEEF7),
          borderRadius: new BorderRadius.all(Radius.circular(20.0))),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: double.infinity,
      height: 250,
      child: InkWell(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 15,
              top: -15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/5.jpg',
                  width: 150,
                  height: 250,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              left: 170,
              top: 20,
              child: Container(
                width: 150,
                child: Text(
                  "ابراهيم سعيد حيمديه",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 170,
              top: 80,
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0Xff1A5F7A),
                  ),
                  Container(
                      width: 120,
                      child: Text(
                        '250',
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
            Positioned(
              left: 170,
              top: 120,
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Color(0Xff1A5F7A),
                  ),
                  Container(
                    width: 120,
                    child: Text(
                      ' دمون الشارع العام',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 180,
              top: 173,
              child: Text(
                "مفتوح",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Details()),
          // );
        },
      ),
    );
  }
}
