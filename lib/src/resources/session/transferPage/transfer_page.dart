import 'package:fintechdemo/src/blocs/transfer_bloc.dart';
import 'package:fintechdemo/src/blocs/user_information.dart';
import 'package:fintechdemo/src/dont_destroy_on_load.dart';
import 'package:fintechdemo/src/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:fintechdemo/src/blocs/transferPage_bloc.dart';

class TransferPage extends StatelessWidget {

  String senderID = "";
  String receiverID = "";
  int money = 0;

  TransferPage({Key? key, required this.senderID, required this.receiverID, required this.money}): super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[700]!,
        title: Text("Chuyển tiền", style: TextStyle(
          color: Colors.black,
        )),
        centerTitle: true,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: TransferInfoScreen(senderID: senderID, receiverID: receiverID,money: money),
      );
  }
}

class TransferInfoScreen extends StatefulWidget {
  String senderID = "";
  String receiverID = "";
  int money = 0;

  TransferInfoScreen({Key? key, required this.senderID, required this.receiverID, required this.money}): super(key:key);
  @override
  _TransferInfoScreen createState() => _TransferInfoScreen(senderID: senderID, receiverID: receiverID, money: money);
}

class _TransferInfoScreen extends State<TransferInfoScreen> {
  AuthBloc bloc = new AuthBloc();

  TextEditingController _sotienController = new TextEditingController();
  TextEditingController _tinnhanController = new TextEditingController();

  bool _sotienVal = false;
  bool _tinnhanVal = false;

  String senderID = "";
  String receiverID = "";
  int money = 0;

  _TransferInfoScreen({Key? key, required this.senderID, required this.receiverID, required this.money});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        //Sender
        Padding(
          padding: EdgeInsets.only(right: 50),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(35)),
              ),
              constraints: BoxConstraints(minHeight: 70, maxHeight: 70),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Expanded(
                      flex: 2,
                      child: CircleAvatar(backgroundColor: Colors.white,child: FlutterLogo(),),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text("${testUser.name}\n${NumberFormat("\$#,##0").format(testUser.money)}"),
                  )
                ],
              )
          ),
        ),
        SizedBox(height: 10,),
        //Receiver
        Padding(
          padding: EdgeInsets.only(left: 50),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
              ),
              constraints: BoxConstraints(minHeight: 70, maxHeight: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 10,
                    child: Text("${Validations.validReceiver[receiverID]}\n${receiverID}", textAlign: TextAlign.end,),
                  ),
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(backgroundColor: Colors.white,child: FlutterLogo(),),
                  ),
                ],
              )
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Input tên đăng nhập
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: StreamBuilder(
              stream: bloc.sotienStream,
              builder: (context, snapshot) => TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: _sotienController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Nhập số tiền cần chuyển",
                    errorText: snapshot.hasError
                        ? snapshot.error.toString()
                        : null,

                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color(0xffCED0D2), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: StreamBuilder(
              stream: bloc.tinnhanStream,
              builder: (context, snapshot) => TextField(

                controller: _tinnhanController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Nhập tin nhắn cần chuyển",
                    errorText: snapshot.hasError
                        ? snapshot.error.toString()
                        : null,
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Color(0xffCED0D2), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),

              ),
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
    if(bloc.isValidAcc(_sotienController.text, _tinnhanController.text)){
    }
    },
              child: Text(
                "Chuyển tiền",
                // cho chữ đăng nhập to hơn
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),

        //Money
      ],
    );
  }
}