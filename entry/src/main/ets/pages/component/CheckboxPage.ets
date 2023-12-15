@Entry
@Component
struct CheckboxPage {
  build() {
    Scroll() {
      Column() {
        Column() {
          Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: "语文" })
              .selectedColor($r('app.color.blue_007DFF'))
              .onChange((result: Boolean) => {
                console.info("chenchen", "语文 check = " + result)
              })

            Text("语文").fontColor($r('app.color.gray_182431')).fontSize(16).margin({ left: 5 })
          }

          Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: "数学" })
              .selectedColor($r('app.color.blue_007DFF'))
              .onChange((result: Boolean) => {
                console.info("chenchen", "数学 check = " + result)
              })
            Text("数学").fontColor($r('app.color.gray_182431')).fontSize(16).margin({ left: 5 })
          }

          Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: "物理" })
              .selectedColor($r('app.color.blue_007DFF'))
              .onChange((result: Boolean) => {
                console.info("chenchen", "物理 check = " + result)
              })
            Text("物理").fontColor($r('app.color.gray_182431')).fontSize(16).margin({ left: 5 })
          }

          Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: "化学" })
              .selectedColor($r('app.color.blue_007DFF'))
              .onChange((result: Boolean) => {
                console.info("chenchen", "化学 check = " + result)
              })
            Text("化学").fontColor($r('app.color.gray_182431')).fontSize(16).margin({ left: 5 })
          }.margin({ bottom: 20 })
        }


        // 全选按钮
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          CheckboxGroup({ group: 'checkboxGroup' })
            .selectedColor($r('app.color.blue_007DFF'))
            .onChange((itemName: CheckboxGroupResult) => {
              console.info("checkbox group content" + JSON.stringify(itemName))
            })
          Text('Select All').fontSize(14).lineHeight(20).fontColor('#182431').fontWeight(500)
        }

        // 选项1
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Checkbox({ name: 'checkbox1', group: 'checkboxGroup' })
            .selectedColor('#007DFF')
            .onChange((value: boolean) => {
              console.info('Checkbox1 change is' + value)
            })
          Text('Checkbox1').fontSize(14).lineHeight(20).fontColor('#182431').fontWeight(500)
        }.margin({ left: 36 })

        // 选项2
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Checkbox({ name: 'checkbox2', group: 'checkboxGroup' })
            .selectedColor('#007DFF')
            .onChange((value: boolean) => {
              console.info('Checkbox2 change is' + value)
            })
          Text('Checkbox2').fontSize(14).lineHeight(20).fontColor('#182431').fontWeight(500)
        }.margin({ left: 36 })

        // 选项3
        Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
          Checkbox({ name: 'checkbox3', group: 'checkboxGroup' })
            .selectedColor('#007DFF')
            .onChange((value: boolean) => {
              console.info('Checkbox3 change is' + value)
            })
          Text('Checkbox3').fontSize(14).lineHeight(20).fontColor('#182431').fontWeight(500)
        }.margin({ left: 36 })
      }
    }
  }
}