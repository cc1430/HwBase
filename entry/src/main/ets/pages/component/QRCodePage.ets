
@Entry
@Component
struct QRCodePage{
  @State inputValue: string = ''
  tempValue: string = ""

  build() {

    Column() {

      QRCode(this.inputValue).color($r('app.color.blue_007DFF')).width(150).height(150)

      TextInput({placeholder:"输入内容"})
        .placeholderColor(Color.Grey)
        .fontSize(14)
        .onChange((value)=> {
          this.tempValue = value
        })
        .onSubmit(()=> {
          this.inputValue = this.tempValue
        })
        .width('90%')
        .height(50)
        .margin({top: 10})

    }.margin(20)
  }
}