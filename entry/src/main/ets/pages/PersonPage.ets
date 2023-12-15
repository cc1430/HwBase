@Entry
@Component
export struct PersonPage {
  build() {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Text("个人")
        .fontSize(20)
    }
  }
}

