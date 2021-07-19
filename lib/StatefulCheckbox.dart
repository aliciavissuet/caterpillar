import 'package:flutter/material.dart';

const IconData delete = IconData(
  0xe1b9,
  fontFamily: 'MaterialIcons',
);

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
    required this.onDelete,
    required this.index,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;
  final Function onDelete;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue);
              },
            ),
            IconButton(
                onPressed: () => onDelete(index),
                icon: Icon(
                  delete,
                  color: Colors.red.shade400,
                  semanticLabel: 'Delete todo',
                ))
          ],
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class StatefulCheckbox extends StatefulWidget {
  StatefulCheckbox({
    Key? key,
    required this.isSelected,
    required this.label,
    required this.onDelete,
    required this.index,
    required this.onSelection,
  }) : super(key: key);
  final isSelected;
  final label;
  final onDelete;
  final index;
  final onSelection;

  @override
  State<StatefulCheckbox> createState() => _StatefulCheckboxState(
      isSelected: isSelected,
      label: label,
      onDelete: onDelete,
      index: index,
      onSelection: onSelection);
}

/// This is the private State class that goes with MyStatefulWidget.
class _StatefulCheckboxState extends State<StatefulCheckbox> {
  _StatefulCheckboxState({
    required this.isSelected,
    required this.label,
    required this.onDelete,
    required this.index,
    required this.onSelection,
  }) : super();
  bool isSelected;
  String label;
  Function onDelete;
  int index;
  Function onSelection;

  @override
  Widget build(BuildContext context) {
    return LabeledCheckbox(
      label: label,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: isSelected,
      onChanged: (bool nextSelected) {
        setState(() {
          isSelected = nextSelected;
        });
        onSelection(index);
      },
      onDelete: onDelete,
      index: index,
    );
  }
}
