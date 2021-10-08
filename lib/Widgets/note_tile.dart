import 'package:daily_quotes_and_reminder_app/Models/note_data.dart';
import 'package:daily_quotes_and_reminder_app/Screens/add_note_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'delete_dialog_box.dart';

class NoteTile extends StatefulWidget {
  final List<NoteData> noteData;
  const NoteTile({Key? key, required this.noteData}) : super(key: key);

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.noteData.isEmpty) {
      return Center(
        child: Text(
          'No notes yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 10),
          // AnimatedList(
          //     key: listKey,
          //     initialItemCount: widget.taskData.length,
          //     itemBuilder: (context, index, animation) {}),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: widget.noteData.length,
              itemBuilder: (BuildContext context, int index) {
                widget.noteData.sort((a, b) => a.date.compareTo(b.date));
                final noteData = widget.noteData[index];
                return buildNote(context, noteData, index);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildNote(context, NoteData noteData, int index) {
    Color color = index.isOdd ? Color(0xffff4081) : Color(0xff448aff);
    String dateAndTime = '';
    dateAndTime += DateFormat.yMMMd().format(noteData.date);
    dateAndTime += ' ' + noteData.time;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: color,
      child: GestureDetector(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DeleteDialogBox(false, noteData: noteData);
              },
              barrierDismissible: false);
        },
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNoteScreen(
                      isEdit: true, noteData: noteData, context: context)));
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          title: Text(
            noteData.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
          subtitle: Text(
            dateAndTime,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
