import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_task_dialog.dart'; // ✅ นำเข้าไฟล์แก้ไขงาน

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final CollectionReference todoCollection = FirebaseFirestore.instance.collection('ToDo');

  void _addTask(String taskName, int duration) {
    if (taskName.isNotEmpty && duration > 0) {
      todoCollection.add({'task': taskName, 'duration': duration, 'status': 'ยังไม่เสร็จ'});
    }
  }

  void _updateTask(String id, int duration, String status) {
    if (duration > 0) {
      todoCollection.doc(id).update({'duration': duration, 'status': status});
    }
  }

  void _deleteTask(String id) {
    todoCollection.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50], // สีพื้นหลังที่เบาๆ
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white), // เพิ่มไอคอนด้านซ้าย
            SizedBox(width: 8),
            Text('To-Do List'),
          ],
        ),
        backgroundColor: Colors.yellow[700], // สี AppBar เป็นสีเหลืองเข้ม
        elevation: 4,
      ),
      body: StreamBuilder(
        stream: todoCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: EdgeInsets.all(8.0),
            children: snapshot.data!.docs.map((doc) {
              return Dismissible(
                key: Key(doc.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _deleteTask(doc.id);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task deleted')));
                },
                background: Container(
                  color: Colors.orangeAccent, // เมื่อสไลด์เพื่อจะลบจะเป็นสีส้ม
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(doc['task'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    subtitle: Text('สถานะ: ${doc['status']}', style: TextStyle(color: Colors.grey)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.yellow[700]),
                          onPressed: () {
                            _showEditDialog(doc.id, doc['duration'], doc['status']);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog();
        },
        backgroundColor: Colors.yellow[700],
        child: Icon(Icons.add), // สีปุ่มเพิ่มเป็นสีเหลืองเข้ม
      ),
    );
  }

  void _showAddDialog() {
    String taskName = '';
    int duration = 1;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('เพิ่มงานใหม่'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'ชื่องาน'),
                onChanged: (value) => taskName = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'ระยะเวลา (วัน)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => duration = int.tryParse(value) ?? 1,
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
                if (taskName.isNotEmpty && duration > 0) {
                  _addTask(taskName, duration);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')));
                }
              },
              child: Text('เพิ่ม'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(String id, int duration, String status) {
    showDialog(
      context: context,
      builder: (context) {
        return EditTaskDialog(
          id: id,
          duration: duration,
          status: status,
          onSave: _updateTask, // ✅ ใช้ฟังก์ชัน update ที่มีอยู่แล้ว
        );
      },
    );
  }
}
