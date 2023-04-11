import 'package:bible_app/Controllers/notes_controller.dart';
import 'package:bible_app/Views/Widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesDailog extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController dateController;
  final VoidCallback onSubmit;

  const NotesDailog({
    Key? key,
    required this.dateController,
    required this.controller,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<NotesDailog> createState() => _NotesDailogState();
}

class _NotesDailogState extends State<NotesDailog> {
  var loading = false;

  DateTime ? dateTime;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10.sp,
            ),
            SizedBox(
              height: 50.sp,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'Add Notes',
                      style: GoogleFonts.raleway(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.sp,
                    right: 10.sp,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              'Notes',
              style: GoogleFonts.raleway(),
            ),
            SizedBox(
              height: 10.sp,
            ),
            MyTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide notes';
                } else {
                  return null;
                }
              },
              maxLines: 2,
              border: const OutlineInputBorder(),
              controller: widget.controller,
              hintText: 'Type here...',
            ),
            SizedBox(
              height: 10.sp,
            ),
            Text(
              'Date',
              style: GoogleFonts.raleway(),
            ),

            SizedBox(height: 5.sp,),

            InkWell(
              onTap: () async {
            var date =   await  showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2011),
                  lastDate: DateTime(2099),
                );

         if(date !=null){
           NotesController.dateTime = date;

           widget.dateController.text =  NotesController.getDate(date);
           setState(() {

           });
         }

              },
            child:  MyTextField(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey
                )
              ),
              enabled: false,
              suffixIcon: Icon(Icons.calendar_today),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date is required';
                  } else {
                    return null;
                  }
                },
                border: const OutlineInputBorder(),
                controller: widget.dateController,
                hintText: 'MM/DD/YYYY',
              ),
              // child: Container(
              //   padding: EdgeInsets.all(5.sp),
              //   margin: EdgeInsets.only(top:5.sp),
              //   height: 40.sp,
              //   decoration:
              //       BoxDecoration(border: Border.all(color: Colors.grey)),
              //   child: dateTime == null ? SizedBox():Text('${dateTime?.month}-${dateTime?.day}-${dateTime?.year}'),
              // ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Close',
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (widget.controller.text.isNotEmpty && widget.dateController.text.isNotEmpty) {
                              loading = true;
                              setState(() {});
                              widget.onSubmit();
                            } else {
                              widget.onSubmit();
                            }
                          },
                          child: const Text(
                            'Submit',
                          ),
                        ),
                ),
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
