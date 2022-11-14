import 'package:flutter/material.dart';
import 'package:priority/todo_provider.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatefulWidget {
  const CustomCard(
      {super.key,
      required this.color,
      required this.label,
      required this.margin});

  final Color color;
  final String label;
  final EdgeInsetsGeometry margin;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late TodosProvider todospro;

  bool visibility = false;
  var todoList;

  @override
  Widget build(BuildContext context) {
    todospro = Provider.of<TodosProvider>(context);

    todoList = todospro.filterAcc(widget.label);
    return Expanded(
      child: Container(
        color: widget.color,
        margin: widget.margin,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 0.2),
                height: 60,
                color: Colors.black.withOpacity(0.7),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.black.withOpacity(0.3),
                child: Visibility(
                  visible: true,
                  replacement: const Text("Loading"),
                  child: FutureBuilder(
                    future: todoList,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<dynamic>> snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.white.withOpacity(0.1),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text((index + 1).toString()),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 35,
                                ),
                                Expanded(
                                  child: Text(
                                    snapshot.data?[index].todo,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                // SizedBox(
                                //   width:
                                //       MediaQuery.of(context).size.width /
                                //           20,
                                // ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.white.withOpacity(0.4),
                                  onPressed: () async {
                                    todospro.deleteTodo(snapshot.data?[index]);
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
