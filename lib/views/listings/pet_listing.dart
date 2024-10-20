import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_store_admin/views/add_food/add_pet.dart';


class PetListing extends StatelessWidget {
  const PetListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text("Pet Listings",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),

      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('pets').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else if(snapshot.hasError || !snapshot.hasData){
                return SizedBox.shrink();
              }
              else if(snapshot.data!.docs.isEmpty){
                return Center(child: Text("No Pet Available"));
              }

              dynamic pets=snapshot.data!.docs;
              return GridView.builder(
                  itemCount: pets.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      mainAxisExtent: 290
                  ),
                  itemBuilder: (context,index){
                    DocumentSnapshot  data = pets[index];
                    dynamic pet = data.data() as Map<String,dynamic>;
                    return Card(
                      elevation: 2,
                      child:
                      GestureDetector(
                        onTap: (){
                          Get.to(AddPet(petData: pet,comingFromListing: true,));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 140,
                                      width: 140,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(pet['image']),
                                              fit: BoxFit.contain)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Name", style: TextStyle(
                                        fontWeight: FontWeight.w600,),),
                                      Expanded(
                                        child: Text("${pet['petname']}", style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 12,),textAlign: TextAlign.end,),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text("Price", style: TextStyle(
                                          fontWeight: FontWeight.w600,),),
                                      ),
                                      // Spacer(),
                                      Text("\$${pet['price']}", style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 12),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text("Age", style: TextStyle(
                                          fontWeight: FontWeight.w600,),),
                                      ),
                                      // Spacer(),
                                      Text("${pet['age']}", style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 12),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Gender", style: TextStyle(
                                        fontWeight: FontWeight.w600,),),
                                      Spacer(),
                                      Text("${pet['gender']}", style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 12),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Vaccinated", style: TextStyle(
                                        fontWeight: FontWeight.w600,),),
                                      Spacer(),
                                      Text("${pet['vaccinated']==true?'Yes':'No'}", style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 12),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),



                                ],


                              ),
                              Icon(Icons.edit,size: 28,)
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
        ),
      ),

    );
  }
}
