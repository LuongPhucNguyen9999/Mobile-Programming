import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/session.dart';
import 'package:flutter_application_2/repositories/sessionlist_repository.dart';
import 'package:flutter_application_2/ui/custom_control.dart';
import '../providers/mainviewmodel.dart';

class SessionList extends StatefulWidget {
  const SessionList({super.key});
  static int idpage = 5;
  @override
  State<SessionList> createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Session List',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<HocPhan>>(
            future: HocPhanRepository().getDsHocPhan(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<HocPhan> dataList = snapshot.data!;
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 180, // Điều chỉnh chiều cao của mỗi khối
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 219, 58, 0.965),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              dataList[index].tenhocphan,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              dataList[index].tengv,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 8, 5, 173),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: CustomButton(
                                  textButton: 'Register',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
