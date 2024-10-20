import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_store_admin/controller/food_controller.dart';

class AddPet extends StatefulWidget {
  final Map<String,dynamic> petData;
  final bool comingFromListing;
  const AddPet({super.key, required this.petData,  this.comingFromListing=false});

  @override
  State<AddPet> createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final FoodController foodController = Get.find();
  RxBool isVaccinated = false.obs;
  RxBool isLoading = false.obs;
  RxString petImage = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodController.image = null;
    if(widget.petData.isNotEmpty){
      petImage.value = widget.petData['image'];
      nameController.text = widget.petData['petname'];
      priceC.text = widget.petData['price'];
      descController.text = widget.petData['description'];
      ageController.text = widget.petData['age'];
      genderController.text = widget.petData['gender'];
      isVaccinated.value = widget.petData['vaccinated'];
    }
  }
Future<void> addPetListing() async{
  try {
    if (isLoading.value == false) {
      isLoading.value = true;
      if (nameController.text
          .trim()
          .isNotEmpty && priceC.text
          .trim()
          .isNotEmpty && descController.text
          .trim()
          .isNotEmpty && ageController.text
          .trim()
          .isNotEmpty) {
        DocumentReference foodRef = await FirebaseFirestore
            .instance.collection('pets').add(
            {
              'petname': nameController.text.trim(),
              'price': priceC.text.trim(),
              'description': descController.text.trim(),
              'age': ageController.text.trim(),
              'image': '',
              'gender': genderController.text.trim(),
              "vaccinated": isVaccinated.value
            });
        await FirebaseFirestore.instance.collection(
            'pets').doc(foodRef.id).set(
            {
              'docId': foodRef.id
            }, SetOptions(merge: true));
        if (foodController.image != null) {
          String imageUrl = await foodController
              .uploadImage(
              foodController.image!, 'pets');
          await FirebaseFirestore.instance.collection(
              'pets').doc(foodRef.id).set(
              {
                'image': imageUrl
              }, SetOptions(merge: true));
        }else{
          await FirebaseFirestore.instance.collection(
              'pets').doc(foodRef.id).set(
              {
                'image': petImage.value
              }, SetOptions(merge: true));
        }
        Get.snackbar("Success", "Pet Data Added");
      }
      isLoading.value = false;
    }
  } catch (e) {

  } finally {
    isLoading.value = false;
    priceC.clear();
    nameController.clear();
    descController.clear();
    foodController.image = null;
  }
}
Future<void> updatePetListing() async{
  try {
    if (isLoading.value == false) {
      isLoading.value = true;
      if (nameController.text
          .trim()
          .isNotEmpty && priceC.text
          .trim()
          .isNotEmpty && descController.text
          .trim()
          .isNotEmpty && ageController.text
          .trim()
          .isNotEmpty) {
      await FirebaseFirestore
            .instance.collection('pets').doc(widget.petData['docId']).set(
            {
              'petname': nameController.text.trim(),
              'price': priceC.text.trim(),
              'description': descController.text.trim(),
              'age': ageController.text.trim(),
              'image': '',
              'gender': genderController.text.trim(),
              "vaccinated": isVaccinated.value
            },SetOptions(merge: true));

        if (foodController.image != null) {
          String imageUrl = await foodController
              .uploadImage(
              foodController.image!, 'pets');
          await FirebaseFirestore.instance.collection(
              'pets').doc(widget.petData['docId']).set(
              {
                'image': imageUrl
              }, SetOptions(merge: true));
        }else{
          await FirebaseFirestore.instance.collection(
              'pets').doc(widget.petData['docId']).set(
              {
                'image': petImage.value
              }, SetOptions(merge: true));
        }
        Get.snackbar("Success", "Pet Data Updated");
      }
      isLoading.value = false;
    }
  } catch (e) {

  } finally {
    isLoading.value = false;

  }
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)!.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        appBar: AppBar(
          title: Text("Add Pet", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),

        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                children: [
                  GetBuilder<FoodController>(builder: (food) {
                    return Stack(
                      children: [
                        CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: food.image != null
                                ? FileImage(food.image!) as ImageProvider<
                                Object>
                                : NetworkImage(petImage.value) as ImageProvider<
                                Object>
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              await food.pickImage();
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Colors.yellow[700],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.camera_alt_outlined, size: 15,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),


                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                        hintText: "Name",
                        // prefixIcon: Icon(Icons.person),
                        border: InputBorder.none),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: priceC,
                    decoration: InputDecoration(
                        hintText: "Price",
                        // labelText: 'City',
                        // prefixIcon: Icon(Icons.location_city),
                        border: InputBorder.none),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    maxLines: 6,
                    controller: descController,
                    decoration: InputDecoration(
                        hintText: "Description",
                        // labelText: 'City',
                        // prefixIcon: Icon(Icons.location_city),
                        border: InputBorder.none),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                        hintText: "Age",
                        // labelText: 'City',
                        // prefixIcon: Icon(Icons.location_city),
                        border: InputBorder.none),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: genderController,
                    decoration: InputDecoration(
                        hintText: "Gender",
                        // labelText: 'City',
                        // prefixIcon: Icon(Icons.location_city),
                        border: InputBorder.none),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(() {
                    return SwitchListTile(
                        title: Text("Vaccinated"),
                        value: isVaccinated.value, onChanged: (val) {
                      isVaccinated.value = val;
                    });
                  }),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(height: 30),
                  Obx(() {
                    return ElevatedButton(onPressed: () async {
                    widget.comingFromListing==false?
                        await addPetListing():
                        await updatePetListing();
                    },
                        child: isLoading.value == false ? Text(widget.comingFromListing==false?"Add":"Update") : Center(
                            child: CircularProgressIndicator())
                    );
                  }),
                  SizedBox(height: 10,),
                  if (widget.comingFromListing == true)
                    ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('pets')
                              .doc(widget.petData['docId'])
                              .delete();
                          Get.back();
                          Get.snackbar("Success", "Item deleted Successfully");

                        },
                        child: Text("Delete"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
