import 'package:civil_defense_app/pages/public/home.dart';
import 'package:civil_defense_app/pages/public/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SliderPage());
}

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Defensa\nCivil",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                height: 200,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black12,
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://live.mrf.io/statics/i/ps/images2.listindiario.com/n/content/661/660726/p/680x460/202103111428561.jpeg?width=1200&enable=upscale",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcMGXK42Pq7BrBDaSNN2A0a81gIyA0GFDNUw&usqp=CAU",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                      ),
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://pbs.twimg.com/media/DZi6aZMVAAAE1mK.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('Siguiente',
                      style: TextStyle(color: Color(0xfffd6c00), fontSize: 18)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
