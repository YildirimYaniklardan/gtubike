import 'package:flutter/material.dart';
import 'package:gtu_bike/components/rounded_button.dart';
import 'package:gtu_bike/screens/registration_screen.dart';



class ContractScreen extends StatefulWidget {
  static const String id = 'contract_screen';

  @override
  _ContractScreenState createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen>{



  @override
  Widget build(BuildContext context) {

              
   
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 50),
          child: Column(
            children: <Widget> [
              Text(
                  '1- Bisiklet kullanımı için geçici tahsis süresi 5 (beş) iş günüdür. Kullanım süresinin uzatılması durumunda kayıt yenileme  işlemi tekrar yapılacaktır. Bu işlemi yapmayan kişiye bir daha bisiklet verilmeyecektir. Bisikletler Sağlık, Kültür ve  Spor Dairesi Başkanlığı Bisiklet Birimine eksiksiz teslim edilecektir.\n\n'
                  '2- Öğrenci/personel bisiklet almak için kimlik kartı ile müracaat edecektir. Bisiklet teslim tutanağı ve taahhütnameyi imzalandıktan sonra bisikletler teslim edilecektir.\n\n'
                  '3- Öğrenci/personel bisikleti ancak kendi adına alabilir. Bir başka kişi adına bisiklet alınması ve işlem yapılması yasaktır. Kendi kullanımı için sadece bir bisiklet alabilir.\n\n'
                  '4- öğrenci/personel teslim aldığı bisikleti teslim edeceği tarihte tüm aksesuarları ile eksiksiz, sağlam ve çalışır durumda teslim edecektir.\n\n'
                  '5- Ögrenci/personel teslim aldıgı bisikleti üçüncü bir şahsa ödünç veremez, kiralayamaz veya satamaz.\n\n' 
                  '6- Öğrenci/personel teslim aldığı bisikletin güvenliğinden sorumludur. Kaybolan bisikletin değerini tazmin etmek ya da yerine eş degerde yenisini alıp teslim etmekle yükümlüdür.\n\n'
                  '7- Öğrenci/personelin Bisiklet Kullanım Kuralları yönergesi ve Şehirlerde Güvenli Bisiklet Kullanma Kılavuzu kurallarına göre uygun kullanacaktır.\n\n'
                  '8- Kullanıcı hatasından kaynaklandığı tespit edilen durumlarda sürüş kuralları ve güvenlik açıklamalarına ve "Şehirlerde Güvenli Bisiklet Kullanma Kılavuzu"ndaki kurallara uygun olmayan kullanımlardan dolayı oluşacak kazalar ve her türlü maddi, manevi zararlar, bisikletlerde meydana gelebilecek her türlü arıza ve onarım giderleri ile ilgili tüm masraflar kullanıcıdan tahsil edilecektir. Hakkında ilgili mevzuat ve yönerge uyarınca işlem yapılır.\n\n'
                  '9- Kullanıcı bu mobil uygulamaya kayıt olduğunda, bu sözleşmeyi kabul etmiş olur.\n\n',
                  
                  style: const TextStyle(color:Colors.black ,fontSize: 17,decoration: TextDecoration.none, fontFamily: 'Raleway'),
                ),       
                RoundedButton(
                  title: 'Okudum, Onaylıyorum.',
              
                  colour: Colors.lightBlue,
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                ),
            ],
          ),

        ),
        
       
        
        

                
        
      );
      

  }}

