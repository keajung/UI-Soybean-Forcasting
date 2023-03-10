import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'API.dart';
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
      title: 'interface',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'interface'),

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
  final _text1 = TextEditingController();  //textediting
  final _text2 = TextEditingController();// controller
  bool _validate1 = false;
  bool _validate2= false;//variable to store the bool value
  final List<String> items = [
    'อิอิ',
    'มกราคม 2566',
    'กุมภาพันธ์ 2566',
    'มีนาคม 2566',
  ];
  String? _chosenValue;
  int index=0;
  String? selectedValue;
  String url='';
  String year='';
  var Data;
  String QueryText = '';

  String valueUs='';
  String valueOil='';
  String valueMonth='';
  String valueYear='';

  void dispose1() {
    _text1.dispose();
    super.dispose();
  }
  void dispose2() {
    _text2.dispose();
    super.dispose();
  }
  void _fetchData(BuildContext context, [bool mounted = true]) async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('รอแป๊ปดิ 💢',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.mitr(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0),
                    ),)
                ],
              ),
            ),
          );
        });

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    await Future.delayed(const Duration(seconds: 6));

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      // title: Text('Soybean Forecast'),
      // ),
      backgroundColor: Color.fromRGBO(255, 194, 0, 0.15),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        Expanded(
                          child: Text(
                            'ทำนายราคากากถั่วเหลืองล่วงหน้า',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 25.0),
                            ),
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
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              // alignment: Alignment.center,
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child:  Container(
                    alignment: Alignment.bottomCenter,
                    width: 550,
                    height: 395, //350
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade300,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:35.0, left:35.0, right: 35.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text('ราคากากถั่วเหลืองอเมริกา ',style: GoogleFonts.mitr(
                                    textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18.0),
                                  ),
                                  ),
                                ),
                                SizedBox(width: 60.0,),
                                FractionalTranslation(
                                  translation: Offset(0,0),
                                  child: SizedBox(
                                    height: 70,
                                    width: 200.0,
                                    child: TextField(
                                      style: GoogleFonts.mitr(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0),
                                      ),
                                      controller: _text1,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        labelStyle: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15.0),
                                        ),
                                        labelText: 'กรอกตัวเลข',
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        errorText: _validate1 ? 'โปรดกรอกช่องนี้' : null,
                                      ),

                                      onChanged: (value) {
                                        valueUs=value;
                                        setState(() {
                                          _text1.text.isEmpty ? _validate1 = true : _validate1 = false;
                                        });

                                      },
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22), //distance textfield 1 & 2
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text('ราคาน้ำมันดิบ ',style: GoogleFonts.mitr(
                                    textStyle: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18.0),
                                  ),
                                  ),
                                ),
                                SizedBox(width: 149.0,),
                                FractionalTranslation(
                                  translation: Offset(0,0),
                                  child: SizedBox(
                                    height: 70,
                                    width: 200.0,
                                    child: TextField(
                                      style: GoogleFonts.mitr(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0),
                                      ),
                                      controller: _text2,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        labelStyle: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15.0),
                                        ),
                                        labelText: 'กรอกตัวเลข',
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        errorText: _validate2 ? 'โปรดกรอกช่องนี้' : null,
                                      ),
                                      onChanged: (value) {
                                        valueOil=value;
                                        setState(() {
                                          _text2.text.isEmpty ? _validate2 = true : _validate2 = false;
                                        });
                                      },
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
                                  Expanded(
                                    child: Text('เลือกเดือนที่ต้องการทำนายผล ',style: GoogleFonts.mitr(
                                      textStyle: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0),
                                    ),),
                                  ),
                                  SizedBox(width: 30.0,),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.grey.shade50,),
                                    width: 200,
                                    child: DropdownButton<String>(
                                      focusColor:Colors.white,
                                      value: _chosenValue,
                                      //elevation: 5,
                                      style: TextStyle(color: Colors.white),
                                      iconEnabledColor:Colors.black,
                                      items: <String>[
                                        'มกราคม 2566',
                                        'กุมภาพันธ์ 2566',
                                        'มีนาคม 2566',
                                      ].map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text (value,
                                            style:GoogleFonts.mitr(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15.0),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      hint:Text(
                                        "โปรดเลือกเดือน",
                                        style: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15.0),
                                        ),
                                      ),
                                      onChanged: (String? value) {

                                        final splitted = value?.split(' ');
                                        print(splitted![0]);
                                        switch(splitted[0]){
                                          case "มกราคม" : {valueMonth='1'; valueYear=splitted[1];} break;
                                          case "กุมภาพันธ์" : {valueMonth='2'; valueYear=splitted[1];}break;
                                          case "มีนาคม" : {valueMonth='3'; valueYear=splitted[1];} break;
                                          case "เมษายน" : {valueMonth='4'; valueYear=splitted[1];} break;
                                          case "พฤษภาคม" : {valueMonth='5'; valueYear=splitted[1];} break;
                                          case "มิถุนายน" : {valueMonth='6'; valueYear=splitted[1];} break;
                                          case "กรกฎาคม" : {valueMonth='7'; valueYear=splitted[1];} break;
                                          case "สิงหาคม" : {valueMonth='8'; valueYear=splitted[1];} break;
                                          case "กันยายน" : {valueMonth='9'; valueYear=splitted[1];} break;
                                          case "ตุลาคม" :{valueMonth='10'; valueYear=splitted[1];} break;
                                          case "พฤศจิกายน" : {valueMonth='11'; valueYear=splitted[1];} break;
                                          case "ธันวาคม" : {valueMonth='12'; valueYear=splitted[1];} break;
                                        }
                                        print('us $valueUs oil $valueOil month $valueMonth and year $valueYear');
                                        setState(() {
                                          _chosenValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ]
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 50,
                                      width: 120,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          // textStyle: TextStyle(fontSize: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          _text1.text.isEmpty ? _validate1 = true : _validate1 = false;
                                          _text2.text.isEmpty ? _validate2 = true : _validate2= false;
                                          if(_validate2==false&&_validate1==false) {
                                            url =
                                            "http://127.0.0.1:5000/api?Soybean_meal_US=$valueUs&Crude_Oil=$valueOil&New_Month=$valueMonth&Year=$valueYear";
                                            print(url);
                                            _fetchData(context);
                                            Data = await Getdata(url);
                                            var DecodedData = jsonDecode(Data);
                                            print('DecodedData $DecodedData');
                                            print('Data $Data');
                                            setState(() {
                                              QueryText = DecodedData.toString();

                                              print(QueryText + 'kuy wan');
                                            });
                                          }else{
                                            setState(() {
                                              _text1.text.isEmpty ? _validate1 = true : _validate1 = false;
                                              _text2.text.isEmpty ? _validate2 = true : _validate2= false;
                                            });
                                          }
                                        },
                                        child: Text("ทำนาย" ,style: GoogleFonts.mitr(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 550,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade300,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ผลลัพธ์การทำนาย',style: GoogleFonts.mitr(
                            textStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0),
                          ),
                          ),
                          SizedBox(width: 94.0,),
                          Container(
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 11.0),
                              child: SizedBox(
                                width: 200.0,
                                child: TextField(
                                  style: GoogleFonts.mitr(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0),
                                  ),
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    hintText: QueryText,
                                    hintStyle: GoogleFonts.mitr(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text('บาท/กิโลกรัม',textAlign : TextAlign.center, style: GoogleFonts.mitr(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0),
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}




