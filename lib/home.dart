import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/network/apicall.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        brightness: Brightness.dark,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: displayUsers,
        ),
      ),
    );
  }

  get displayUsers {
    return FutureBuilder(
        future: ApiCall().getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: true,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    scrollDirection: Axis.vertical,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(4.0),
                        height: 140,
                        child: loading,
                      );
                    }));
          } else {
            print(snapshot.data[0]);

            return ListView.builder(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                primary: true,
                itemBuilder: (BuildContext context, int index) {
                  final list = snapshot.data[index];
                  return Container(
                    margin: EdgeInsets.all(4.0),
                    height: 140,
                    child: usersWidget(
                        userName: list.name,
                        email: list.email,
                        city: list.address.city,
                        company: list.company.name),
                  );
                });
          }
        });
  }

  get loading {
    var width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.white,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: Colors.red)),
      child: Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  width: width - 20,
                ),
                flex: 1,
              ),
              Divider(),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  width: width - 30,
                ),
                flex: 1,
              ),
              Divider(),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  width: width - 40,
                ),
                flex: 1,
              ),
              Divider(),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  width: width - 50,
                ),
                flex: 1,
              ),
            ],
          )),
    );
  }
}

class usersWidget extends StatelessWidget {
  final String userName;
  final String email;
  final String city;
  final String company;

  const usersWidget(
      {Key key, this.userName, this.email, this.city, this.company})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: Colors.red)),
      child: Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: Column(
            children: [
              Expanded(
                child: Text(userName),
                flex: 1,
              ),
              Divider(),
              Expanded(
                child: Text(email),
                flex: 1,
              ),
              Divider(),
              Expanded(
                child: Text(city),
                flex: 1,
              ),
              Divider(),
              Expanded(
                child: Text(company),
                flex: 1,
              )
            ],
          )),
    );
  }
}
