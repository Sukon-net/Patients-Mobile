part of '../../presentation/home_screen.dart';

class _SukonCategories extends StatelessWidget {
  const _SukonCategories({required this.onSukonCategoriesClicked});

  final void Function() onSukonCategoriesClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.categories_of_sukon.tr(),
              style: TextStyles.size20Weight600.copyWith(
                color: context.colors.primaryTextColor,
              ),
            ),
            IconButton(
              onPressed: onSukonCategoriesClicked,
              icon: SvgPicture.asset(Assets.assetsBlueArrowBackIcon),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TherapyCategory(
                iconPath: Assets.assetsGeneralPsychiatryIcon,
                name: LocaleKeys.general_psychiatry.tr(),
                onIconClicked: () {},
              ),
              TherapyCategory(
                iconPath: Assets.assetsMentalDisordersIcon,
                name: LocaleKeys.mental_disorders.tr(),
                onIconClicked: () {},
              ),
              TherapyCategory(
                iconPath: Assets.assetsAddictionTreatmentIcon,
                name: LocaleKeys.addiction_treatment.tr(),
                onIconClicked: () {},
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TherapyCategory(
              iconPath: Assets.assetsChildrenAndTeenagersIcon,
              name: LocaleKeys.children_and_teenagers.tr(),
              onIconClicked: () {},
            ),
            TherapyCategory(
              iconPath: Assets.assetsFamilyTherapyIcon,
              name: LocaleKeys.family_therapy.tr(),
              onIconClicked: () {},
            ),
            TherapyCategory(
              iconPath: Assets.assetsCognitiveBehavioralIcon,
              name: LocaleKeys.cognitive_behavioral.tr(),
              onIconClicked: () {},
            ),
          ],
        ),
      ],
    );
  }
}
