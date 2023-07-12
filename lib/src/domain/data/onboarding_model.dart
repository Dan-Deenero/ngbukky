import 'package:ngbuka/src/core/shared/app_images.dart';

List<OnboardingModel> onboarding = [
  OnboardingModel(
      heading: "Expand your reach and serve more customers",
      description:
          "Expand your reach and connect with car owners in need of your expertise.",
      image: AppImages.firstMan),
  OnboardingModel(
      heading: "Access user requests and leads",
      description:
          "Gain access to a stream of user requests  leads from car owners in your areas",
      image: AppImages.secondMan),
];

class OnboardingModel {
  String heading;
  String description;
  String image;
  OnboardingModel(
      {required this.heading, required this.description, required this.image});
}
