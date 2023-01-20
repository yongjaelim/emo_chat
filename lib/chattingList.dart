import 'package:emo_chat/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'chattingA.dart';

class ChattingHome extends StatelessWidget {
  const ChattingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChattingListView(),
    );
  }
}

class ChattingListView extends StatefulWidget {
  const ChattingListView({Key? key}) : super(key: key);

  @override
  State<ChattingListView> createState() => _ChattingListViewState();
}

class _ChattingListViewState extends State<ChattingListView> {
  var userList = ['김파수', '이파수', '박파수'];
  var userProfilePics = ['images/1.png', 'images/2.png', 'images/3.png'];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6; //for the future implementation like conversation preview
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          'Chatting',
        ),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
              onPressed: () {
                // QuickAlert.show(
                //   title: '로그아웃',
                //   barrierDismissible: false,
                //   //barrierColor: Colors.deepOrange,
                //   showCancelBtn: true,
                //   context: context,
                //   onConfirmBtnTap: (){
                //     Navigator.push(context, MaterialPageRoute(
                //         builder: (context) => const LogIn()
                //     ));
                //   },
                //   onCancelBtnTap: (){
                //     Navigator.pop
                //   },
                //   type: QuickAlertType.info,
                //   text: '정말 로그아웃 하시겠습니까?',
                //   confirmBtnText: '예',
                //   cancelBtnText: '아니오',
                //   confirmBtnColor: Colors.blue,
                // );
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        content: const Text('로그아웃 하시겠습니까?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('아니오')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('예'))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const ChattingRoom1()));
              debugPrint(userList[index]);
            },
            child: Card(
                child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(userProfilePics[index]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          userList[index],
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
                ],
            )),
          );
        },
      ),
    );
  }
}
