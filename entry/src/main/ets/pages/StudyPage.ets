import CommonConstants from '../common/CommonConstants'

@Entry
@Component
export struct StudyPage {
  build() {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Text("学习")
        .fontSize(20)
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}