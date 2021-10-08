import 'package:daily_quotes_and_reminder_app/Models/note_data.dart';
import 'package:daily_quotes_and_reminder_app/Screens/add_note_screen.dart';
import 'package:daily_quotes_and_reminder_app/Utils/boxes.dart';
import 'package:daily_quotes_and_reminder_app/Utils/constants.dart';
import 'package:daily_quotes_and_reminder_app/Widgets/note_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesTab extends StatefulWidget {
  @override
  State<NotesTab> createState() => _NotesTabState();
}

class _NotesTabState extends State<NotesTab> {
  String searchField = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddNoteScreen(isEdit: false, context: context)));
          },
          child: Icon(Icons.add, size: 36, color: Color(0xfff50057)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Notepad',
                        style: kTabLabelTextStyle.copyWith(
                            color: Color(0xff111111))),
                    SizedBox(height: 5),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          searchField = value;
                        });
                      },
                      showCursor: true,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Color(0xff111111), fontSize: 18)),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 1),
                        filled: true,
                        fillColor: Color(0x222979ff),
                        prefixIcon: Image.asset('images/search_icon.png',
                            color: Colors.black54),
                        hintText: 'Search notes',
                        hintStyle: GoogleFonts.pacifico(
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.black54)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      )),
                  child: ValueListenableBuilder<Box<NoteData>>(
                    valueListenable: Boxes.getNoteData().listenable(),
                    builder: (context, box, _) {
                      var noteDataList;
                      if (searchField.isEmpty) {
                        noteDataList = box.values.toList().cast<NoteData>();
                      } else {
                        noteDataList = box.values
                            .toList()
                            .where((element) {
                              return element.note
                                      .toLowerCase()
                                      .contains(searchField.toLowerCase()) ||
                                  element.title
                                      .toLowerCase()
                                      .contains(searchField.toLowerCase());
                            })
                            .toList()
                            .cast<NoteData>();
                      }
                      return NoteTile(noteData: noteDataList);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
