import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text("All Users",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        
      ),
      body:FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('users').get(),
          builder: (context, usersnapshot) {
            if(usersnapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            else if(usersnapshot.hasError || !usersnapshot.hasData){
              return SizedBox.shrink();
            }
            else if(usersnapshot.data!.docs.isEmpty){
              return Center(child: Text("No Users",style: TextStyle(color: Colors.black),),);
            }
            return ListView.builder(
                itemCount: usersnapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  DocumentSnapshot data = usersnapshot.data!.docs[index];
                  final users= data.data() as Map<String,dynamic>;

                  return Card(
                    elevation: 2,
                    child: ListTile(

                      leading: Container(
                        height: 60,
                        width: 60,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            image: DecorationImage(image: NetworkImage(users.containsKey('image')?users['image']:''),fit: BoxFit.contain)
                        ),
                      ),
                      title:Text("${users['username']}",style: TextStyle(fontWeight: FontWeight.w600,),),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Age: ${users['age'].toString().toUpperCase()}",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.red),),
                          Text("${users['email']}",style: TextStyle(fontWeight: FontWeight.w500),),
                        ],
                      ),
                      subtitle: Text("Phone: ${users['mobileno']}"),
                    ),
                  );
                });
          }
      ),

    );
  }
}
