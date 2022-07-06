import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kurdish_names/src/model/kurdish_names_model.dart';

import '../serivices/kurdish_names_service.dart';

class KurdishNamesView extends StatefulWidget {
  const KurdishNamesView({Key? key}) : super(key: key);

  @override
  State<KurdishNamesView> createState() => _KurdishNamesViewState();
}

class _KurdishNamesViewState extends State<KurdishNamesView> {
  String gender = "F";
  String recordCount = "10";
  final RequestNames _requestNames = RequestNames();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton(
                    hint: Text("Gender"),
                    items: [
                      DropdownMenuItem(
                        child: Text("Male"),
                        value: "M",
                      ),
                      DropdownMenuItem(
                        child: Text("Female"),
                        value: "F",
                      ),
                    ],
                    onChanged: (obj) {
                      setState(() {
                        gender = obj.toString();
                      });
                    }),
                DropdownButton(
                    hint: Text("Limit"),
                    items: [
                      DropdownMenuItem(
                        child: Text("10"),
                        value: "10",
                      ),
                      DropdownMenuItem(
                        child: Text("20"),
                        value: 20,
                      ),
                      DropdownMenuItem(
                        child: Text("30"),
                        value: 30,
                      ),
                      DropdownMenuItem(
                        child: Text("40"),
                        value: 40,
                      ),
                    ],
                    onChanged: (obj) {
                      setState(() {
                        recordCount = obj.toString();
                      });
                    }),
              ],
            ),
            Expanded(
                child: Directionality(
              textDirection: TextDirection.rtl,
              child: FutureBuilder<KurdishName>(
                future: _requestNames.getnames(recordCount, gender),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (!snapshot.hasData) {
                    return Text("no data");
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.names.length,
                        itemBuilder: (ctx, index) {
                          return ExpansionTile(
                            title: Text(
                              snapshot.data!.names[index].name,
                            ),
                            children: [
                              Text(snapshot.data!.names[index].desc),
                            ],
                          );
                        });
                  }
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
