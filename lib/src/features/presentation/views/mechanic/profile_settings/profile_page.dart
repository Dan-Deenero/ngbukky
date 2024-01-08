import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngbuka/src/config/keys/app_routes.dart';
import 'package:ngbuka/src/core/shared/app_images.dart';
import 'package:ngbuka/src/domain/repository/auth_repository.dart';
import 'package:ngbuka/src/domain/repository/mechanic_repository.dart';
import 'package:ngbuka/src/features/presentation/widgets/app_spacer.dart';
import 'package:ngbuka/src/features/presentation/widgets/custom_text.dart';

import '../../../../../core/shared/colors.dart';

Widget card(
  String title,
  String subtitle,
  String image,
) =>
    Card(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: ListTile(
        leading: SvgPicture.asset(
          image,
          width: 25,
          height: 25,
        ),
        trailing: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
                text: title,
                fontSize: 15,
                textColor: AppColors.black,
                fontWeight: FontWeight.bold),
            customText(
                text: subtitle, fontSize: 12, textColor: AppColors.textColor)
          ],
        ),
      ),
    );

class ProfileSettings extends HookWidget {
  const ProfileSettings({super.key});

  static final AuthRepo _authRepo = AuthRepo();
  static final MechanicRepo _mechanicRepo = MechanicRepo();

  @override
  Widget build(BuildContext context) {
    final firstname = useState<String?>('Damini');
    final lastname = useState<String?>('Otobo');
    final email = useState<String?>('dadaobo@gmail.com');
    final phone = useState<String?>('+234 701 111 0153');
    final photo = useState<File?>(
        File('https://cdn-icons-png.flaticon.com/512/149/149071.png'));
    final profileImage = useState<String?>(AppImages.usericon);
    final ImagePicker picker = ImagePicker();
    final FirebaseStorage storage = FirebaseStorage.instance;

    getUserProfile() {
      _authRepo.getMechanicProfile().then((value) {
        firstname.value = value.firstname!;
        lastname.value = value.lastname!;
        email.value = value.email!;
        phone.value = value.phoneNumber!;
        profileImage.value = value.profileImageUrl!;
      });
    }

    Future<void> updateProfilePicture() async {
      // Select image
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        photo.value = File(pickedFile.path);
      }

      // Upload to Firebase
      final ref = storage.ref('uploads/${DateTime.now()}.png');
      await ref.putFile(photo.value!);

      // Get URL
      final url = await ref.getDownloadURL();

      // Update Firestore
      var data = {"profileImageUrl": url};

      bool result = await _mechanicRepo.saveProfileImage(data);

      if (result) {
        profileImage.value = url;
      }
    }

    void signOut() async {
      bool result = await _authRepo.signOut();
      if (result) {
        if (context.mounted) {
          context.go(AppRoutes.login);
        }
      }
    }

    useEffect(() {
      getUserProfile();
      return null;
    }, [profileImage.value]);
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: 27.h,
                decoration: const BoxDecoration(
                  color: AppColors.containerGrey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightSpace(7),
                        customText(
                            text: "Profile settings",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            textColor: AppColors.black),
                        heightSpace(1),
                        SizedBox(
                          width: 250,
                          child: customText(
                              text:
                                  "View analytics and withdraw from your wallet",
                              fontSize: 14,
                              textColor: AppColors.black),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () => context.push(AppRoutes.notification),
                        child: SvgPicture.asset(AppImages.notification))
                  ],
                ),
              ),
              Positioned(
                top: 22.h,
                left: 15,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.backgroundGrey,
                      backgroundImage: NetworkImage(profileImage.value!),
                      radius: 55, // Adjust the size of the circle as needed
                    ),
                    InkWell(
                      onTap: updateProfilePicture,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          heightSpace(10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                          text: "${firstname.value}, ${lastname.value}",
                          fontSize: 26,
                          textColor: AppColors.orange,
                          fontWeight: FontWeight.w600),
                      heightSpace(2),
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.emailIcon),
                          widthSpace(2),
                          bodyText("${email.value}")
                        ],
                      ),
                      heightSpace(1),
                      Row(
                        children: [
                          SvgPicture.asset(AppImages.phone),
                          widthSpace(2),
                          bodyText("${phone.value}")
                        ],
                      ),
                      heightSpace(3),
                      Container(
                        width: double.infinity,
                        height: 2.h,
                        decoration: const BoxDecoration(
                            border: Border(
                          top: BorderSide(color: AppColors.borderGrey),
                        )),
                      ),
                      heightSpace(2),
                      GestureDetector(
                        onTap: () =>
                            context.push(AppRoutes.personalInfoSettings),
                        child: card(
                          "Personal profile",
                          "Edit your personal information",
                          AppImages.nameIcon,
                        ),
                      ),
                      heightSpace(2),
                      GestureDetector(
                        onTap: () =>
                            context.push(AppRoutes.businessInfoSettings),
                        child: card(
                          "Business profile",
                          "Edit your business information",
                          AppImages.box,
                        ),
                      ),
                      heightSpace(2),
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.contactPage),
                        child: card(
                          "Contact Ngbuka",
                          "Contact Ngbuka customer care",
                          AppImages.box,
                        ),
                      ),
                      heightSpace(2),
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.addWallet),
                        child: card(
                          "Wallet",
                          "Manage your saved account number",
                          AppImages.contact,
                        ),
                      ),
                      heightSpace(10),
                      InkWell(
                        onTap: signOut,
                        child: Row(
                          children: [
                            customText(
                                text: 'Log out',
                                fontSize: 17,
                                textColor: AppColors.textGrey),
                            widthSpace(2),
                            SvgPicture.asset(
                              AppImages.logoutIcon,
                              width: 25,
                            )
                          ],
                        ),
                      ),
                      heightSpace(4),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
