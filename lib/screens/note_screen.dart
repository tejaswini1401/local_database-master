import 'package:flutter/material.dart';
import 'package:local_database/models/note_model.dart';
import 'package:local_database/services/database_helper.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;
  const NoteScreen({
    Key? key,
    this.note
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final companyController = TextEditingController();
    final jobRoleController = TextEditingController();
    final jobIdController = TextEditingController();
    final jdController = TextEditingController();

    if(note != null){
      companyController.text = note!.company;
      jobRoleController.text = note!.jobRole;
      jobIdController.text = note!.jobId;
      jdController.text = note!.jdis;
    

    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: Text( note == null
              ? 'Add a Job'
              : 'Edit Job details',
              style: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: Colors.white,
              ),
          ),
          centerTitle: true,
           shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 210, 102, 186),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'Enter the Job Details below',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: companyController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Enter Company Name',
                    labelText: 'Enter CompanyName',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: jobRoleController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Enter Job Role',
                    labelText: 'Enter JobRole',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
               Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: jobIdController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Enter Job Id',
                    labelText: 'Enter JobId',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            TextFormField(
              controller: jdController,
              decoration: const InputDecoration(
                  hintText: 'Job Description',
                  labelText: 'Skill Required',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 5,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final company = companyController.value.text;
                      final jobRole = jobRoleController.value.text;
                      final jobId = jobIdController.value.text;
                      final jd = jdController.value.text;

                      if (company.isEmpty || jobRole.isEmpty || jobId.isEmpty || jd.isEmpty) {
                        return;
                      }

                      final Note model = Note(company:company, jobRole:jobRole,jobId:jobId,jdis:jd, id: note?.id);
                      if(note == null){
                        await DatabaseHelper.addNote(model);
                      }else{
                        await DatabaseHelper.updateNote(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color:  Color.fromARGB(255, 210, 102, 186),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                            ),
                            backgroundColor: const MaterialStatePropertyAll( Color.fromARGB(255, 210, 102, 186),)
                          ),
                    child: Text( note == null
                      ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 20,color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
