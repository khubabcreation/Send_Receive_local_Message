import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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

  final SmsSendStatusListener listener = (SendStatus status) {
// Handle the status
  };

  ///this is my init state....
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - kTextTabBarHeight;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Message Screen')),
      body: Container(
        height: height,
        width: width,
        child: Container(
          padding: EdgeInsets.only(top: 50, left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recieved SMS Text:",
                style: TextStyle(fontSize: 30),
              ),
              Divider(),
              Text(
                "SMS Text:" + sms,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  sendsms() async {
    final SmsSendStatusListener listener = (SendStatus status) {
      print(status.toString());
    };

// Check if a device is capable of sending SMS
    bool? canSendSms = await telephony.isSmsCapable;
    print(canSendSms.toString());
// Get sim state
    SimState simState = await telephony.simState;
    print(simState.toString());
    telephony.sendSms(
        to: "+923085401148",
        message: mybody.toString(),
        statusListener: listener);
  }
}
