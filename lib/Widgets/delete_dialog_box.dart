import 'package:daily_quotes_and_reminder_app/Models/db_models.dart';
import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialogBox extends StatelessWidget {
  final String message = 'Are you sure?';
  final TaskData data;
  DeleteDialogBox(this.data);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                message,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        label: Text('No',
                            style: TextStyle(fontSize: 22, color: Colors.red))),
                    TextButton.icon(
                        onPressed: () {
                          DbModels.deleteTask(data);
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green,
                        ),
                        label: Text('Yes',
                            style:
                                TextStyle(fontSize: 22, color: Colors.green))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
