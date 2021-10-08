import 'package:daily_quotes_and_reminder_app/Models/db_models.dart';
import 'package:daily_quotes_and_reminder_app/Models/note_data.dart';
import 'package:daily_quotes_and_reminder_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddNoteScreen extends StatefulWidget {
  final bool isEdit;
  final NoteData? noteData;
  final BuildContext? context;
  const AddNoteScreen(
      {Key? key, required this.isEdit, this.context, this.noteData})
      : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String note = '';
  String title = '';
  final _noteController = TextEditingController();
  final _titleController = TextEditingController();
  String _dateAndTime = '';
  String _dateAndTimeFromDatabase = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Color(0xff2979ff),
              size: 32,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Note',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Color(0xff111111))),
            ),
            (title.isNotEmpty || note.isNotEmpty)
                ? IconButton(
                    onPressed: () {
                      if (widget.isEdit) {
                        DbModels.editNote(
                            noteData: widget.noteData!,
                            title: title,
                            note: note,
                            date: DateTime.now(),
                            time: TimeOfDay.now().format(context));
                      } else {
                        DbModels.addNote(
                            title: title,
                            note: note,
                            date: DateTime.now(),
                            time: TimeOfDay.now().format(context));
                      }
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.check,
                      color: Color(0xff2979ff),
                      size: 32,
                    ))
                : Text(''),
          ],
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1),
            Text(
              !widget.isEdit ? _dateAndTime : _dateAndTimeFromDatabase,
              style: kTaskStatusTextStyle.copyWith(color: Color(0xff111111)),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              controller: _titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0x222979ff),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Title',
                hintStyle: GoogleFonts.pacifico(
                    textStyle: TextStyle(fontSize: 16, color: Colors.black54)),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0x222979ff),
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      note = value;
                    });
                  },
                  controller: _noteController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter note here',
                    hintStyle: GoogleFonts.pacifico(
                        textStyle:
                            TextStyle(fontSize: 16, color: Colors.black54)),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _dateAndTime = DateFormat.yMMMd().format(DateTime.now()) +
        ' ' +
        TimeOfDay.now().format(widget.context!);
    if (widget.isEdit) {
      _titleController.text = widget.noteData!.title;
      _noteController.text = widget.noteData!.note;
      title = widget.noteData!.note;
      note = widget.noteData!.note;
      _dateAndTimeFromDatabase =
          DateFormat.yMMMd().format(widget.noteData!.date) +
              ' ' +
              widget.noteData!.time;
    }
  }
}
