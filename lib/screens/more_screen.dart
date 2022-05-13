import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  var _isLoading = false;
  late String username, email, photoUrl, uid;

  @override
  void initState() {
    _isLoading = true;
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
      email = prefs.getString('email')!;
      photoUrl = prefs.getString('photoUrl')!;
      uid = prefs.getString('uid')!;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('More'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: darkGrayColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              photoUrl,
                              height: 80.0,
                              width: 80.0,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                email.split('@')[0].substring(0, 3) +
                                    '***' +
                                    email.split('@')[1],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: lightGrayColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 25),
                          GestureDetector(
                            onTap: () => {},
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: lightGrayColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    text: 'Log Out',
                    onPressed: () => AuthMethods().signOut(),
                  ),
                ],
              ),
            ),
    );
  }
}
