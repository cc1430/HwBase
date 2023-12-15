import router from '@ohos.router'
import CommonConstants from '../common/CommonConstants'
import { LogUtils } from '../utils/LogUtils'
import PreferencesUtils from '../utils/PreferencesUtils'
import showToast from '../utils/ToastUtils'

@Entry
@Component
export struct Index {
  @State itemList: Array<string> = [
    "ButtonPage",
    "TodoListPage",
    "CheckboxPage",
    "ImagePage",
    "LoadingProgressPage",
    "NavigationPage",
    "ProgressPage",
    "QRCodePage",
    "ColumnSplitPage",
    "GridPage",
    "ListPage",
    "VideoPage"
  ]

  async aboutToAppear() {
    let a = await PreferencesUtils.getString("access_token")
    showToast(a)
  }

  build() {
    Column() {
      List() {
        ForEach(this.itemList, (item: string, index: number) => {
          ListItem() {
            Button(item)
              .width(CommonConstants.FULL_LENGTH)
              .height(60)
              .type(ButtonType.Normal)
              .backgroundColor(Color.Transparent)
              .fontColor(Color.Black)
              .onClick(() => {
                console.log('click index = ' + index)
                switch (index) {
                  case 0:
                    router.pushUrl({ url: "pages/component/ButtonPage" })
                    break;
                  case 1:
                    router.pushUrl({ url: "pages/component/TodoListPage" })
                    break;
                  case 2:
                    router.pushUrl({ url: "pages/component/CheckboxPage" })
                    break;
                  case 3:
                    router.pushUrl({ url: "pages/component/ImagePage" })
                    break;
                  case 4:
                    router.pushUrl({ url: "pages/component/LoadingProgressPage" })
                    break;
                  case 5:
                    router.pushUrl({ url: "pages/component/NavigationPage" })
                    break;
                  case 6:
                    router.pushUrl({ url: "pages/component/ProgressPage" })
                    break;
                  case 7:
                    router.pushUrl({ url: "pages/component/QRCodePage" })
                    break;
                  case 8:
                    router.pushUrl({ url: "pages/component/ColumnSplitPage" })
                    break;
                  case 9:
                    router.pushUrl({ url: "pages/component/GridPage" })
                    break;
                  case 10:
                    router.pushUrl({ url: "pages/component/ListPage" })
                    break;
                  case 11:
                    router.pushUrl({ url: "pages/component/VideoPage" })
                    break;
                  default:
                    break;
                }
              })
          }
        }, (item, index) => index + JSON.stringify(item))
      }
      .divider({ strokeWidth: 1, color: "#dfdfdf" })
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}