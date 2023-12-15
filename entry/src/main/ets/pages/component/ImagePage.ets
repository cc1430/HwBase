@Entry
@Component
struct ImagePage {
  build() {
    Column() {
      Text("加载本地图片").fontSize(16).fontColor($r('app.color.gray_182431')).alignSelf(ItemAlign.Start)

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
        Image($r('app.media.boy'))
          .width(120)
          .height(120)
          .margin(8)

        Image($r('app.media.boy2'))
          .width(120)
          .height(120)
          .margin(8)
          .borderColor(Color.Black)
          .borderWidth(1)
          .borderRadius(20)
      }

      Text("加载GIF图片")
        .fontSize(16)
        .fontColor($r('app.color.gray_182431'))
        .alignSelf(ItemAlign.Start)
        .margin({ top: 20 })

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
        Image($r('app.media.search_loading'))
          .width(150)
          .height(110)
          .margin(8)
      }

      Text("加载网络图片")
        .fontSize(16)
        .fontColor($r('app.color.gray_182431'))
        .alignSelf(ItemAlign.Start)
        .margin({ top: 20 })

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
        Image("https://c-ssl.dtstatic.com/uploads/item/202003/29/20200329182006_eX3wM.thumb.1000_0.jpeg")
          .width(250)
          .height(250)
          .margin(8)
          .onComplete((event) => {
            console.info("chenchen", "onComplete width = " + event.width + ", height = " + event.height)
            console.info("chenchen", "onComplete componentWidth = " + event.componentWidth + ", componentHeight = " + event.componentHeight)
            console.info("chenchen", "onComplete loadingStatus = " + event.loadingStatus)
          })
          .onError((event?: {
            componentWidth: number;
            componentHeight: number;
            message: string
          }) => {
            console.error("chenchen", "onError message = " + event.message)
          })
      }
    }
    .margin(10)
  }
}