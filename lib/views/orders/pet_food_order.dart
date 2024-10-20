import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_store_admin/views/orders/order_details/food_order_details.dart';
import 'package:pet_store_admin/views/orders/order_details/pet_order_details.dart';

class PetFoodOrder extends StatelessWidget {
  const PetFoodOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text("Food Orders",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),

      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('orders').where("type",isEqualTo: 'petfood').snapshots(),
          builder: (context, ordersnapshot) {
            if(ordersnapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            else if(ordersnapshot.hasError || !ordersnapshot.hasData){
              return SizedBox.shrink();
            }
            else if(ordersnapshot.data!.docs.isEmpty){
              return Center(child: Text("No Orders",style: TextStyle(color: Colors.white),),);
            }
            return ListView.builder(
                itemCount: ordersnapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  DocumentSnapshot order = ordersnapshot.data!.docs[index];
                  var ordersData = order.data() as Map<String,dynamic>;
                  return GestureDetector(
                    onTap: (){
                      Get.to(FoodOrderDetails(order: ordersData,));
                    },
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Container(
                          height: 60,
                          width: 60,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              image: DecorationImage(image: NetworkImage(order['image']),fit: BoxFit.contain)
                          ),
                        ),
                        title:Text("${order['name']}",style: TextStyle(fontWeight: FontWeight.w600,),),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${order['orderStatus'].toString().toUpperCase()}",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.red),),
                          ],
                        ),
                        subtitle: Text("\$ ${order['price'].toString()}"),
                      ),
                    ),
                  );
                });
          }
      ),

    );
  }
}
