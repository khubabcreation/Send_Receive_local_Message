import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String sms = "";
  Telephony telephony = Telephony.instance;
  String? myadress = '';
  String? mybody = '';
  int? mydata;
  final phoneController = TextEditingController();
  SharedPreferences? pref;
  List<String> list = <String>[];
  final SmsSendStatusListener listener = (SendStatus status) {
// Handle the status
  };
  @override
  void initState() {
    assighnInstance();
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address); //+977981******67, sender nubmer
        print(message.body); //sms text
        print(message.date); //1659690242000, timestamp
        setState(() {
          sms = message.body.toString();
          myadress = message.address;
          mybody = message.body;
          mydata = message.date;
          if (myadress == '+923044978989') {
            sendsms();
          } else {
            print('Not forward please');
          }
        });
      },
      listenInBackground: false,
    );
    super.initState();
  }

  assighnInstance() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kTextTabBarHeight;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneController,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            ElevatedButton(
                onPressed: () {
                  String phoneNumber = phoneController.text.trim();
                  list.add(phoneNumber);
                  pref!.setStringList('phone', list);
                  list = pref!.getStringList('phone')!;
                  List? oldlist = pref!.getStringList('phone');

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Number Added')));
                  phoneController.clear();
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                child: Text('Save Number')),
          ],
        ),
      ),
    );
  }

  sendsms() async {
    final SmsSendStatusListener listener = (SendStatus status) {
      print(status.toString());
    };
    SharedPreferences pref = await SharedPreferences.getInstance();
// Check if a device is capable of sending SMS
    bool? canSendSms = await telephony.isSmsCapable;
    print(canSendSms.toString());
// Get sim state
    SimState simState = await telephony.simState;
    print(simState.toString());
    List? oldlist = pref.getStringList('phone');
    for (int i = 0; i < oldlist!.length; i++) {
      telephony.sendSms(
          to: oldlist[i].toString(),
          message: mybody.toString(),
          statusListener: listener);
    }
  }
}
