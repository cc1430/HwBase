@Entry
@Component
struct LoadingProgressPage {
  build() {
    Column() {
      LoadingProgress()
        .width(150)
        .height(150)
        .color($r('app.color.blue_007DFF'))
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}