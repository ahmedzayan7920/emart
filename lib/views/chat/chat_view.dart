import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/models/message_model.dart';
import 'package:emart/views/chat/messages_view.dart';
import 'package:intl/intl.dart' as intl;

import '../../consts/app_consts.dart';
import '../../models/user_model.dart';
import '../../services/firestore_services.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Chats".text.color(AppColors.darkFontGrey).fontFamily(AppStyles.semiBold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreServices.getChats(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MessageModel> chats = List.from(
                  snapshot.data!.docs.map(
                    (e) => MessageModel.fromMap(e.data() as Map<String, dynamic>),
                  ),
                );
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final uid = chats[index].senderId == AppFirebase.currentUser!.uid
                        ? chats[index].receiverId
                        : chats[index].senderId;
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirestoreServices.getUser(uid: uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            UserModel user =
                                UserModel.fromMap(snapshot.data!.docs.first.data() as Map<String, dynamic>);
                            return ListTile(
                              onTap: () {
                                Get.to(() => MessagesView(sellerName: user.name, sellerId: user.uid));
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: CachedNetworkImageProvider(
                                  user.profileUrl,
                                ),
                              ),
                              title: user.name.text.fontFamily(AppStyles.semiBold).size(18).ellipsis.make(),
                              subtitle: chats[index].message.text.size(16).make(),
                              trailing: (intl.DateFormat("hh:mm a")
                                      .format(DateTime.fromMillisecondsSinceEpoch(chats[index].time)))
                                  .text
                                  .fontFamily(AppStyles.semiBold)
                                  .color(Colors.grey)
                                  .make(),
                            );
                          } else {
                            return const LinearProgressIndicator();
                          }
                        });
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
