import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flash_chat/components/rounded_button.dart';



class QrScreen extends StatefulWidget{
  static const String id = 'qr_screen';
  @override
  _QrCodeState createState() => _QrCodeState();
}


class _QrCodeState extends State<QrScreen>{
  String _data="";
  
  _scan() async{

    await FlutterBarcodeScanner.scanBarcode("#000000", "Cancel", true, ScanMode.BARCODE).then((value) => setState(()=>_data = value));
  
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
      
      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      
      children: [
        
        RoundedButton(
              title: 'LÜTFEN BİSİKLET ÜZERİNDEKİ BARKODU OKUTUN',
              colour: Colors.blueAccent[700],
              onPressed: _scan
            ),
        Text(_data),
      ],)
    );
  }
}
