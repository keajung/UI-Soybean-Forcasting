import 'package:flutter/material.dart';
import 'API.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = [
    'มกราคม 2566',
    'กุมภาพันธ์ 2566',
    'มีนาคม 2566',
  ];
  String? selectedValue;
  String url='';
  String QueryText = 'Query';

  var Data;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Soybean Forecast'),
      // ),
      backgroundColor: Color.fromRGBO(255, 194, 0, 0.15),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  Image.asset('asset/images/logo.png',
                    fit: BoxFit.fill,
                    height: 55,
                  ),
                  Text(
                    'ทำนายราคากากถั่วเหลืองล่วงหน้า',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mitr(
                      textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 25.0),
                    ),
                  ),
                ],
              ),
              decoration: new BoxDecoration(
                color: Colors.amber.shade300,
                boxShadow: [new BoxShadow(blurRadius: 3.0)],
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage('asset/images/banner2.png'),
                              fit: BoxFit.cover
                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 21.0),
            child: Container(
                width: 630,
                height: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber.shade300,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text('ราคากากถั่วเหลืองอเมริกา ',style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0),
                            ),
                            ),
                            SizedBox(width: 40.0,),
                            SizedBox(
                            width: 200.0,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'กรอกตัวเลข',
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),
                                onChanged: (value) {
                                  url = 'http://127.0.0.1:5000/api?Soybean_meal_US=' + value.toString();
                                  print(url);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('ราคาน้ำมันดิบ ',style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0),
                            ),
                            ),
                            SizedBox(width: 129.0,),
                            SizedBox(
                              width: 200.0,
                              child: TextField(
                                onChanged: (value) {
                                url = url+'&Crude_Oil=' + value.toString();
                                print(url);
                                },
                                decoration: InputDecoration(
                                  labelText: 'กรอกตัวเลข',
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                           Text('เลือกเดือนที่ต้องการทำนายผล ',style: GoogleFonts.mitr(
                             textStyle: TextStyle(
                                 color: Colors.black87,
                                 fontSize: 18.0),
                           ),),
                            SizedBox(width: 40.0,),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.grey.shade50,),
                              width: 170,
                              child: DropdownButton(
                                value: items[0],
                                items: items.map((country){
                                  return DropdownMenuItem(
                                    child: Text(country),
                                    value: country,
                                  );
                                }).toList(),
                                onChanged: (country){

                                  var string = country.toString();
                                  final splitted = string.split(' ');
                                  print(splitted[0]);
                                  switch(splitted[0]){
                                    case "มกราคม" : {url = url+'&New_Month=' +'1&Year='+splitted[1];} break;
                                    case "กุมภาพันธ์" : {url = url+'&New_Month=' +'2&Year='+splitted[1];} break;
                                    case "มีนาคม" : {url = url+'&New_Month=' +'3&Year='+splitted[1];} break;
                                    case "เมษายน" : {url = url+'&New_Month='+'4&Year='+splitted[1];} break;
                                    case "พฤษภาคม" : {url = url+'&New_Month=' +'5&Year='+splitted[1];} break;
                                    case "มิถุนายน" : {url = url+'&New_Month=' +'6&Year='+splitted[1];} break;
                                    case "กรกฎาคม" : {url = url+'&New_Month=' +'7&Year='+splitted[1];} break;
                                    case "สิงหาคม" : {url = url+'&New_Month=' +'8&Year='+splitted[1];} break;
                                    case "กันยายน" : {url = url+'&New_Month=' +'9&Year='+splitted[1];} break;
                                    case "ตุลาคม" : {url = url+'&New_Month=' +'10&Year='+splitted[1];} break;
                                    case "พฤศจิกายน" : {url = url+'&New_Month=' +'11&Year='+splitted[1];} break;
                                    case "ธันวาคม" : {url = url+'&New_Month=' +'12&Year='+splitted[1];} break;
                                  }

                                  print(url);
                                  print("You selected: $country");
                                  setState(() {
                                    // index =
                                  });
                                },
                              ),
                            ),
                          ]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0 ,bottom: 30.0),
                        child: Row(
                          children: [
                            SizedBox(width: 455.0,),
                            Container(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      textStyle: TextStyle(fontSize: 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                      ),
                                  ),
                                  onPressed: () async {
                                    Data = await Getdata("http://127.0.0.1:5000/api?Soybean_meal_US=1&Crude_Oil=2&New_Month=3&Year=4");
                                    var DecodedData = jsonDecode(Data);
                                    print('DecodedData $DecodedData');
                                    print('Data $Data');
                                    setState(() {
                                      QueryText = DecodedData.toString();
                                      print(QueryText+'kuy wan');
                                    });
                                  },
                                  child: const Text("ทำนาย")),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('ผลลัพธ์การทำนาย ',style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0),
                            ),
                            ),
                            SizedBox(width: 94.0,),
                            Container(
                              child: SizedBox(
                                width: 200.0,
                                child: TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    // labelText: '',
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    hintText: QueryText,
                                  ),
                                ),
                              ),
                            ),
                            Text(' บาท/กิโลกรัม',textAlign : TextAlign.end, style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0),
                            ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),


            ),
          ),
        ],
      ),


    );
  }
}
