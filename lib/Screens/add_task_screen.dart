import 'package:daily_quotes_and_reminder_app/Models/db_models.dart';
import 'package:daily_quotes_and_reminder_app/Models/task_data.dart';
import 'package:daily_quotes_and_reminder_app/Utils/constants.dart';
import 'package:daily_quotes_and_reminder_app/Widgets/main_button_widget.dart';
import 'package:daily_quotes_and_reminder_app/Widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  final bool isEdit;
  final TaskData? taskData;
  final BuildContext? context;
  AddTaskScreen(this.isEdit, [this.taskData, this.context]);
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTaskTitle = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  var _dateController = TextEditingController();
  var _titleController = TextEditingController();
  var _timeController = TextEditingController();
  bool _isTimeValid = false;
  bool _isDateValid = false;
  bool _isNotificationOn = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff414F56),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(0xff8eacbb),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.isEdit ? 'Edit Task' : 'Add New Task',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: kBigTextStyle,
                ),
              ),
              SizedBox(height: 10.0),
              TextFieldWidget(
                textInputType: TextInputType.text,
                controller: _titleController,
                label: 'Enter task here',
              ),
              SizedBox(height: 5),
              TextFieldWidget(
                readOnly: true,
                validity: _isDateValid,
                controller: _dateController,
                label: 'Choose a date',
                textInputType: TextInputType.datetime,
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.lime,
                  size: 30,
                ),
                onIconPressed: () async {
                  await _selectDate();
                },
              ),
              SizedBox(height: 5),
              (_isDateValid)
                  ? TextFieldWidget(
                      readOnly: true,
                      validity: _isTimeValid,
                      controller: _timeController,
                      label: 'Set time',
                      textInputType: TextInputType.datetime,
                      icon: Icon(Icons.access_time_outlined,
                          color: Colors.lime, size: 30),
                      onIconPressed: () async {
                        await _selectTime();
                      },
                    )
                  : Container(),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isNotificationOn = !_isNotificationOn;
                  });
                },
                child: Icon(
                    _isNotificationOn ? Icons.alarm_on : Icons.alarm_off,
                    color: Colors.lime,
                    size: 50),
              ),
              SizedBox(height: 10),
              MainButtonWidget(
                  title: widget.isEdit ? 'Save' : 'Add',
                  onTap: () async {
                    if (validate()) {
                      if (widget.isEdit) {
                        await DbModels.editTask(widget.taskData!,
                            title: _titleController.text,
                            dateExpected: _selectedDate,
                            dateCompleted: null,
                            timeExpected:
                                _selectedTime.toString().substring(10, 15),
                            timeCompleted: null,
                            isAlarmOn: _isNotificationOn,
                            isCompleted: false);
                        Navigator.pop(context);
                      } else {
                        await DbModels.addTask(
                            title: _titleController.text,
                            dateExpected: _selectedDate,
                            dateCompleted: null,
                            timeExpected:
                                _selectedTime.toString().substring(10, 15),
                            timeCompleted: null,
                            isAlarmOn: _isNotificationOn,
                            isCompleted: false);
                        Navigator.pop(context);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Refer step 1
      firstDate: DateTime(_selectedDate.year, _selectedDate.month - 1),
      lastDate: DateTime(_selectedDate.year + 2),
      errorFormatText: 'Enter the date in a correct format',
      errorInvalidText: 'You cannot make that date selection',
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        setDateControllerText(picked);

        if (DateTime(picked.year, picked.month, picked.day).isBefore(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
          _isDateValid = false;
        } else {
          _isDateValid = true;
        }

        //print(TimeOfDay.fromDateTime(DateTime.now()));
      });
  }

  Future<void> _selectTime() async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: _selectedTime.hour == TimeOfDay.now().hour &&
              _selectedTime.minute == TimeOfDay.now().minute
          ? TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 0)
          : _selectedTime,
    );
    if (result != null) {
      setState(() {
        _selectedTime = result;
        setTimeControllerText(result);
        if (DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
            .isAfter(DateTime.now())) {
          _isTimeValid = true;
        } else if (result.hour < TimeOfDay.now().hour ||
            (result.hour == TimeOfDay.now().hour &&
                result.minute < TimeOfDay.now().minute)) {
          _isTimeValid = false;
        } else {
          _isTimeValid = true;
        }
      });
    }
  }

  bool validate() {
    //return _titleController.text.isEmpty || !_isTimeValid || !_isDateValid? false:true;
    if (_titleController.text.isEmpty) {
      EasyLoading.showError('Yo babe! Field cannot be empty');
      return false;
    } else if (!_isDateValid) {
      EasyLoading.showError('Why would you want to do this task yesterday?');
      return false;
    } else if (!_isTimeValid) {
      EasyLoading.showError('you can\'t travel back in time, or can you?');
      return false;
    } else {
      return true;
    }
  }

  String formatTimeToString(String time) {
    String hr = time.substring(0, 2);
    String min = time.substring(3, 5);
    int hour = int.parse(hr);
    int minute = int.parse(min);
    return TimeOfDay(hour: hour, minute: minute).format(widget.context!);
  }

  TimeOfDay formatStringToTimeOfDay(String time) {
    String hr = time.substring(0, 2);
    String min = time.substring(3, 5);
    int hour = int.parse(hr);
    int minute = int.parse(min);
    return TimeOfDay(hour: hour, minute: minute);
  }

  void putData() {
    if (widget.isEdit) {
      final taskData = widget.taskData!;
      setDateControllerText(taskData.dateExpected);
      _titleController.text = taskData.title;
      _timeController.text = formatTimeToString(taskData.timeExpected);
      _isNotificationOn = taskData.isAlarmOn;
      _isTimeValid = true;
      _isDateValid = true;
      _selectedDate = widget.taskData!.dateExpected;
      _selectedTime = formatStringToTimeOfDay(widget.taskData!.timeExpected);
    }
  }

  void setDateControllerText(DateTime picked) {
    if (picked.day == DateTime.now().day + 1 &&
        picked.month == DateTime.now().month &&
        picked.year == DateTime.now().year) {
      _dateController.text = 'Tomorrow';
    } else if (picked.day == DateTime.now().day - 1 &&
        picked.month == DateTime.now().month &&
        picked.year == DateTime.now().year) {
      _dateController.text = 'Yesterday';
    } else if (picked.day == DateTime.now().day &&
        picked.month == DateTime.now().month &&
        picked.year == DateTime.now().year) {
      _dateController.text = 'Today';
    } else {
      _dateController.text = DateFormat('EEEE, d MMM, yyyy').format(picked);
    }
  }

  void setTimeControllerText(TimeOfDay time) {
    _timeController.text = time.format(context);
  }

  @override
  void initState() {
    putData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timeController.dispose();
    _dateController.dispose();
    _titleController.dispose();
  }
}
