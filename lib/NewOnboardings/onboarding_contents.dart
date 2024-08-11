class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Embark: Your Journey Begins",
    image: "assets/images/image1.jpeg",
    desc: "Embark on a journey of discovery and exploration with our app.",
  ),
  OnboardingContents(
    title: "Flavors Around the Pakistan",
    image: "assets/images/image2.jpeg",
    desc:
        "Indulge your senses and treat your taste buds to a world of culinary delights",
  ),
  OnboardingContents(
    title: "Drive Easy: Seamless Travel",
    image: "assets/images/image3.jpeg",
    desc:
        "Travel with peace of mind knowing that your transportation needs are taken care.",
  ),
  
];
