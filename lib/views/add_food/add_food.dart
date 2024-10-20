import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pet_store_admin/controller/food_controller.dart';
import 'package:pet_store_admin/views/add_food/add_pet.dart';

class AddFood extends StatefulWidget {
  final Map<String, dynamic> foodData;
  final bool comingFromListing;
  const AddFood(
      {super.key, required this.foodData, this.comingFromListing = false});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final FoodController foodController = Get.find();
  RxString foodImage = ''.obs;

  RxBool isLoading = false.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodController.image = null;
    if (widget.foodData.isNotEmpty) {
      foodImage.value = widget.foodData['image'];
      nameController.text = widget.foodData['name'];
      priceC.text = widget.foodData['price'];
      descController.text = widget.foodData['description'];
    }
  }

  Future<void> addFoodListing() async {
    try {
      if (isLoading.value == false) {
        isLoading.value = true;
        if (nameController.text.trim().isNotEmpty &&
            priceC.text.trim().isNotEmpty &&
            descController.text.trim().isNotEmpty) {
          DocumentReference foodRef =
              await FirebaseFirestore.instance.collection('petsFood').add({
            'name': nameController.text.trim(),
            'price': priceC.text.trim(),
            'description': descController.text.trim(),
            'image': ''
          });
          await FirebaseFirestore.instance
              .collection('petsFood')
              .doc(foodRef.id)
              .set({'docId': foodRef.id}, SetOptions(merge: true));
          if (foodController.image != null) {
            String imageUrl = await foodController.uploadImage(
                foodController.image!, 'petFoodPics');
            await FirebaseFirestore.instance
                .collection('petsFood')
                .doc(foodRef.id)
                .set({'image': imageUrl}, SetOptions(merge: true));
          } else {
            await FirebaseFirestore.instance
                .collection('petsFood')
                .doc(foodRef.id)
                .set({'image': foodImage.value}, SetOptions(merge: true));
          }
          Get.snackbar("Success", "Food Data Added");
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

  Future<void> updateFoodListing() async {
    try {
      if (isLoading.value == false) {
        isLoading.value = true;
        if (nameController.text.trim().isNotEmpty &&
            priceC.text.trim().isNotEmpty &&
            descController.text.trim().isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('petsFood')
              .doc(widget.foodData['docId'])
              .set({
            'name': nameController.text.trim(),
            'price': priceC.text.trim(),
            'description': descController.text.trim(),
            'image': ''
          }, SetOptions(merge: true));

          if (foodController.image != null) {
            String imageUrl = await foodController.uploadImage(
                foodController.image!, 'petFoodPics');
            await FirebaseFirestore.instance
                .collection('petsFood')
                .doc(widget.foodData['docId'])
                .set({'image': imageUrl}, SetOptions(merge: true));
          } else {
            await FirebaseFirestore.instance
                .collection('petsFood')
                .doc(widget.foodData['docId'])
                .set({'image': foodImage.value}, SetOptions(merge: true));
          }
          Get.snackbar("Success", "Food Data Updated");
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
          title: Text(
            "Add Food",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        floatingActionButton: widget.comingFromListing == false
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.to(AddPet(
                    petData: {},
                  ));
                },
                child: Icon(Icons.add),
              )
            : null,
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
                                ? FileImage(food.image!)
                                    as ImageProvider<Object>
                                : NetworkImage(foodImage.value)
                                    as ImageProvider<Object>),
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
                              child: Icon(Icons.camera_alt_outlined,
                                  size: 15, color: Colors.white),
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
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(height: 30),
                  Obx(() {
                    return ElevatedButton(
                        onPressed: () async {
                          widget.comingFromListing == false
                              ? await addFoodListing()
                              : await updateFoodListing();
                        },
                        child: isLoading.value == false
                            ? Text(widget.comingFromListing == false
                                ? "Add"
                                : "Update")
                            : Center(child: CircularProgressIndicator()));
                  }),
                  SizedBox(height: 10,),
                  if (widget.comingFromListing == true)
                    ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('petsFood')
                              .doc(widget.foodData['docId'])
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
