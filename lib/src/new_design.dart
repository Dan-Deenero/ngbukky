import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          width: double.infinity,
          height: 340,
          color: Colors.blue,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Ama",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Center(
                        child: Icon(
                          Icons.notifications,
                          size: 25,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 28,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Center(
                            child: Text(
                          "2",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  color: const Color.fromARGB(255, 4, 66, 117),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Column(children: [
                    Text("Next pay date"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "15 July",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "3747.00 DH",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Available balance",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Center(
                  child: Text(
                    "Latest transactions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: 80,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.arrow_downward,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      "200.00",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Column(children: [
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Sent",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("July 05, 2023")
                    ]),
                  ),
                )
              ],
            ),
          )),
        )
      ]),
    );
  }
}
