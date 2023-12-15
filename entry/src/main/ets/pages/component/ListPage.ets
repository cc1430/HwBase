import { DocumentBean } from '../../model/DocumentBean'
import DocumentViewModel from '../../viewmodel/DocumentViewModel'

@Entry
@Component
struct ListPage {
  scroller: Scroller = new Scroller()
  @State dataList: Array<DocumentBean> = new Array

  aboutToAppear() {
    this.dataList = DocumentViewModel.getData()
  }

  build() {
    Column() {
      List({ scroller: this.scroller }) {
        ForEach(this.dataList, (item: DocumentBean) => {
          ListItem() {
            Text(item.docName)
              .fontSize(16)
              .width('100%')
              .height(100)
              .textAlign(TextAlign.Center)
              .alignSelf(ItemAlign.Center)
              .fontColor(Color.Black)
              .fontSize(20)
              .backgroundColor(item.getBackgroundColor())
          }
          .width("100%")
          .swipeAction({
            end: this.SwipeItem(item)
          })
        }, item => JSON.stringify(item))
      }
      .divider({ strokeWidth: 1 })
    }
  }

  @Builder SwipeItem(item: DocumentBean) {

    Row(){
      Button('Edit')
        .backgroundColor($r('app.color.green_13c69a'))
        .fontColor(Color.White)
        .fontSize(16)
        .width(80)
        .height('100%')
        .type(ButtonType.Normal)

      Button('Delete')
        .backgroundColor($r('app.color.red_fe4343'))
        .fontColor(Color.White)
        .fontSize(16)
        .width(80)
        .height('100%')
        .type(ButtonType.Normal)
        .onClick(()=>{
          let index = this.dataList.indexOf(item)
          this.dataList.splice(index, 1)
        })
    }
  }
}

