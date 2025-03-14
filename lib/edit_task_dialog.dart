import 'package:flutter/material.dart';

class EditTaskDialog extends StatelessWidget {
  final String id;
  final int duration;
  final String status;
  final Function(String id, int newDuration, String newStatus) onSave;

  const EditTaskDialog({
    super.key,
    required this.id,
    required this.duration,
    required this.status,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    int newDuration = duration;
    String newStatus = status;

    return StatefulBuilder(
      builder: (context, setDialogState) {
        return AlertDialog(
          title: Text('แก้ไขงาน'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'ระยะเวลา (วัน)'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setDialogState(() {
                    newDuration = int.tryParse(value) ?? duration;
                  });
                },
              ),
              DropdownButton<String>(
                value: newStatus,
                items: ['ยังไม่เสร็จ', 'เสร็จแล้ว']
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setDialogState(() {
                      newStatus = value;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ยกเลิก'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700]),
              onPressed: () {
                if (newDuration > 0) {
                  onSave(id, newDuration, newStatus);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ระยะเวลาไม่ถูกต้อง')));
                }
              },
              child: Text('บันทึก'),
            ),
          ],
        );
      },
    );
  }
}
