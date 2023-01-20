import 'package:emo_chat/chattingList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Emo Chat', home: LogIn());
  }
}

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController idArea = TextEditingController();
  TextEditingController pwdArea = TextEditingController();

  void checkLoginField(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => const ChattingHome()
    ));
    idArea.clear();
    pwdArea.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 167,
                        ),
                        Image.asset('images/EmoChat.png'),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 50,
                          width: 330,
                          child: TextField(
                            //obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), labelText: 'ID를 입력해주세요'),
                            controller: idArea,
                            onChanged: (text) {
                              setState((){});
                            },
                            onSubmitted: (text) {
                              setState((){});
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: 330,
                          child: TextField(
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '패스워드를 입력해주세요'),
                            controller: pwdArea,
                            onChanged: (text) {
                              setState((){});
                            },
                            onSubmitted: (text) {
                              setState((){});
                            }
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                      StatefulBuilder(
                          builder: (BuildContext context, StateSetter setState) {
                            return ElevatedButton(
                                onPressed: idArea.text.isNotEmpty && pwdArea.text.isNotEmpty ? () => checkLoginField(context) : null,
                                    //() => checkLoginField(context),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrange,
                                    //(idArea.text.isNotEmpty && pwdArea.text.isNotEmpty) ? Colors.deepOrange : Colors.grey,
                                    minimumSize: const Size(330, 50)
                                ),
                                child: const Text('Login')
                            );
                          }
                      )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
