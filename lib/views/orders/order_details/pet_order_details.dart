import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetOrderDetails extends StatefulWidget {
  final Map<String, dynamic> order;

  const PetOrderDetails({super.key, required this.order});

  @override
  State<PetOrderDetails> createState() => _PetOrderDetailsState();
}

class _PetOrderDetailsState extends State<PetOrderDetails> {
  RxString orderStatus = ''.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderStatus.value = widget.order['orderStatus'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text("Order Details", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),

      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(
              widget.order['orderBy']).get(),
          builder: (context, usersnapshot) {
            if (usersnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            else if (usersnapshot.hasError || !usersnapshot.hasData) {
              return SizedBox.shrink();
            }
            else if (!usersnapshot.data!.exists) {
              return Center(child: Text(
                "No User Exist", style: TextStyle(color: Colors.black),),);
            }
            dynamic userData = usersnapshot.data!.data();
            return Center(
              child: Card(
                elevation: 2,
                child:

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(widget.order['image']),
                                  fit: BoxFit.contain)
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text("${widget.order['name']}", style: TextStyle(
                            fontWeight: FontWeight.w600,),),
                          Spacer(),
                          Text("\$${widget.order['price']}", style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order By: ${userData['username']}",
                            style: TextStyle(fontWeight: FontWeight.w400,),),
                          Obx(() {
                            return Text(
                              "${orderStatus.value.toString().toUpperCase()}",
                              style: TextStyle(fontWeight: FontWeight.w500,
                                  color: Colors.red),);
                          }),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Text("Address: ${widget.order['address']}",
                        style: TextStyle(fontWeight: FontWeight.w400,),),
                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Post Code: ${widget.order['postCode']}",
                            style: TextStyle(fontWeight: FontWeight.w400,),),

                          Text("Phone: ${widget.order['phoneNumber']}",
                            style: TextStyle(fontWeight: FontWeight.w400,),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Center(child: ElevatedButton(onPressed: () async {
                        if (orderStatus.value == 'pending') {
                          await FirebaseFirestore.instance.collection('orders')
                              .doc(widget.order['orderId'])
                              .update(
                              {
                                'orderStatus': 'completed'
                              });
                          orderStatus.value = 'completed';
                        }
                      }, child: Obx(() {
                        return Text(orderStatus.value == 'pending'
                            ? "Complete Order"
                            : "Completed");
                      })))


                    ],


                  ),
                ),
              ),
            );
          }
      ),

    );
  }
}
