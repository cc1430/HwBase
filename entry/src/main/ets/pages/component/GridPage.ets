@Entry
@Component
struct GridPage{
  @State row: String[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
  @State array: String[] = ['0', '1', '2', '3', '4']
  scroller: Scroller = new Scroller()

  build() {
    Column() {
      Grid(this.scroller) {
        ForEach(this.row, (day1: string) => {
          ForEach(this.array, (day: string) => {
            GridItem() {
              Text(day1 + "-"+ day)
                .fontSize(16)
                .backgroundColor($r('app.color.blue_007DFF'))
                .width('100%')
                .height(100)
                .textAlign(TextAlign.Center)
                .fontColor(Color.White)
                .fontSize(20)
            }
          }, day => day)
        }, day1 => day1)
      }
      .columnsTemplate("1fr 1fr 1fr 1fr 1fr")
      .columnsGap(10)
      .rowsGap(10)
      .margin(10)
      .height('60%')
      .onScrollIndex((index: number) => {
        console.debug("onScrollIndex = " + index)
      })
    }
  }
}