import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barber/view/widget/alertdilog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String id;
  final String imageurl;
  Details({Key? key, required this.id, required this.imageurl})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  CollectionReference customersref =
      FirebaseFirestore.instance.collection('customers');
  CollectionReference usersref = FirebaseFirestore.instance.collection('users');
  late QuerySnapshot querySnapshotForUser;
  late QuerySnapshot querySnapshotForCustomer;
  Map<String, dynamic> userInfo = {};
  getUserInfo() async {
    print(DateTime.now().millisecondsSinceEpoch);
    querySnapshotForUser = await usersref
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();


    userInfo = {
      'name': querySnapshotForUser.docs[0].data()['name'],
      'imageurl': querySnapshotForUser.docs[0].data()['imageurl'],
      'barber_ID': widget.id,
      'order': DateTime.now().millisecondsSinceEpoch,
      'uid':FirebaseAuth.instance.currentUser!.uid,
    };
  }

  addCustomer() async {
    CustomAlertDialog.showLoading(context);

    querySnapshotForCustomer =await customersref.where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid ).get();
    print(querySnapshotForCustomer.docs.length);
    if (querySnapshotForCustomer.docs.length==0) {
      await customersref.add(userInfo);
      Navigator.of(context).pop();
    }
    else {
      Navigator.of(context).pop();
      AwesomeDialog(
        context: context,
        title: 'Error',
        body: Text('لقد حجزت بالفعل'),
      )..show();
    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Container(
        width: 100,
        child: FloatingActionButton(
          backgroundColor: Color(0Xff1A5F7A),
          onPressed: () async {
            await addCustomer();
          },
          child: Text('احجز الأن'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
        ),
      ),
      body: Container(
        color: Color(0XffEDEEF7),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 175,
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                  child: Image.asset(
                    'assets/10.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: width / 2 - 60,
                  top: 125,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.network(
                        widget.imageurl,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 70,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: customersref
                    .where('barber_ID', isEqualTo: widget.id)
                    .orderBy('order', descending: false)
                    .snapshots(),
                builder: (context, snaphot) {
                  if (snaphot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 50,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (snaphot.hasData) {
                    return ListView.builder(
                        itemCount: snaphot.data!.docs.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ListTile(
                              leading:
                                  snaphot.data!.docs[i].data()['imageurl'] ==
                                          'null'
                                      ? Icon(
                                          Icons.person_rounded,
                                          size: 60,
                                          color: Color(0Xff1A5F7A),
                                        )
                                      : ClipOval(
                                          child: Image.network(
                                            snaphot.data!.docs[i]
                                                .data()['imageurl'],
                                            fit: BoxFit.cover,
                                            width: 60,
                                          ),
                                        ),
                              title: Text(
                                snaphot.data!.docs[i].data()['name'],
                              ),
                            ),
                          );
                        });
                  }
                  if (snaphot.hasError) {
                    print(snaphot.error);
                    return Center(
                      child: Text(snaphot.error.toString()),
                    );
                  }

                  return Container(child: Text('sdsdsdfsdfsd'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
