import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectionsWidget extends StatefulWidget {
  final String title;
  final List<String> options;
  final Set<String> selectedOptions;

  const SelectionsWidget({super.key, required this.title, required this.options, required this.selectedOptions});

  @override
  State<SelectionsWidget> createState() => _SelectionsWidgetState();
}

class _SelectionsWidgetState extends State<SelectionsWidget> {
  bool showOptions = false;

  void toggleOptions() {
    setState(() {
      showOptions = !showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 20)),
            IconButton(
              onPressed: toggleOptions,
              icon: Icon(showOptions ? Icons.remove : Icons.add),
            ),
          ],
        ),
        const Divider(),
        if (showOptions)
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: widget.options.map((option) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.selectedOptions.contains(option)) {
                      widget.selectedOptions.remove(option);
                    }else{
                      widget.selectedOptions.add(option);
                    }
                  });
                },
                child: Card(
                  color: widget.selectedOptions.contains(option) ? Colors.green : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(option, style: TextStyle(fontSize: 15, color: widget.selectedOptions.contains(option) ? Colors.white : Colors.black)),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
