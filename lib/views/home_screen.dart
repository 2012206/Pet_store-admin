import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_store_admin/views/add_food/add_food.dart';
import 'package:pet_store_admin/views/listings/food_listing.dart';
import 'package:pet_store_admin/views/listings/pet_listing.dart';
import 'package:pet_store_admin/views/orders/pet_food_order.dart';
import 'package:pet_store_admin/views/orders/pet_order.dart';
import 'package:pet_store_admin/views/users/all_users.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text("Pet Store",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
    floatingActionButton: FloatingActionButton(
       backgroundColor: Colors.white,

      onPressed: (){
      Get.to(AddFood(foodData: {},));
    },child: Icon(Icons.add
    ),),
    body: GridView(

      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      children: [
        GestureDetector(
          onTap: (){
          Get.to(AllUsers());
          },
          child: Container(

            height: 150,
            alignment: Alignment.center,
            width: double.infinity,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Text("Users",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
          ),
        ),
        GestureDetector(
          onTap: (){
            Get.to(PetOrder());
          },
          child: Container(
            height: 150,
            alignment: Alignment.center,
            width: double.infinity,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Center(child: Text("Pet Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),)),
          ),
        ),
        GestureDetector(
          onTap: (){
            Get.to(PetFoodOrder());
          },
          child: Container(
            height: 150,
            alignment: Alignment.center,
            width: double.infinity,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Text("Pet Food Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),textAlign: TextAlign.center,),
          ),
        ),
        GestureDetector(
          onTap: (){
            Get.to(PetListing());
          },
          child: Container(
            height: 150,
            alignment: Alignment.center,
            width: double.infinity,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Text("Pet Listings",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
          ),
        ),
        GestureDetector(
          onTap: (){
            Get.to(FoodListing());
          },
          child: Container(
            height: 150,
            alignment: Alignment.center,
            width: double.infinity,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Text("Food Listings",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
          ),
        ),


      ],
    ),
    );

  }
}
