import CommonConstants from '../common/CommonConstants'
import { DeviceInfoBean } from '../model/response/DeviceInfoBean'
import DeviceListViewModel from '../viewmodel/DeviceListViewModel'
import PreferencesUtils from '../utils/PreferencesUtils'
import router from '@ohos.router'
import PullDownRefresh from '../view/PullDownRefresh'

@Entry
@Component
export struct DeviceListPage {
  @State phone: string = ""
  @State accessToken: string = ""
  @State showToken: boolean = false
  @State devices: Array<DeviceInfoBean> = new Array
  @State isRefresh: boolean = false
  @State pullDownText: Resource = $r('app.string.refresh_text')
  private currentOffsetY: number = 0;

  async aboutToAppear() {
    this.accessToken = await PreferencesUtils.getString("access_token")
    this.phone = await PreferencesUtils.getString("phone")
    this.getData()
  }

  getData() {
    DeviceListViewModel.getDeviceList(this.accessToken, result => {
      this.isRefresh = false
      if (result.system.code == 0) {
        this.devices = result.result.devices
      }
    })
  }

  @Builder DeviceItem(deviceInfo: DeviceInfoBean) {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Center }) {
      Image(deviceInfo.icon)
        .width(75)
        .height(75)
        .alignSelf(ItemAlign.Center)
        .margin(10)

      Flex({ direction: FlexDirection.Column }) {
        Row() {
          Text(deviceInfo.deviceName)
            .fontSize(20)

          Text(deviceInfo.roomName)
            .fontSize(14)
            .fontColor($r('app.color.grey_8F8F8F'))
            .margin({ left: 10 })
        }

        Text(deviceInfo.deviceUid)
          .fontSize(14).margin({ top: 5 })

        Text("gid: " + deviceInfo.gid)
          .fontSize(14).margin({ top: 5 })

        Text("分享设备: " + deviceInfo.isShare)
          .fontSize(14).margin({ top: 5 })
      }.margin({ top: 10, bottom: 10, right: 10 })
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(120)
    .backgroundColor($r('app.color.grey_F6F6F6'))
    .borderRadius(10)
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {

      Text(this.phone)
        .fontColor($r('app.color.black_2C2C2C'))
        .fontSize(24)
        .margin({ left: 20, top: 20 })
        .onClick(() => {
          this.showToken = !this.showToken
        })

      Text(this.accessToken)
        .fontColor($r('app.color.grey_8F8F8F'))
        .fontSize(14)
        .margin({ left: 20, top: 5 })
        .visibility(this.showToken ? Visibility.Visible : Visibility.None)
        .onClick(() => {
          router.pushUrl({ url: "pages/Index" })
        })

      Divider()
        .vertical(false)
        .strokeWidth(1)
        .color($r('app.color.grey_C2C2C2'))
        .margin({ top: 5, left: 20, right: 20 })

      Scroll() {
        Column() {
          if (this.isRefresh) {
            PullDownRefresh({ refreshText: $pullDownText })
          }
          List({ space: 5 }) {
            if (this.devices != null) {
              ForEach(this.devices, (item) => {
                ListItem() {
                  this.DeviceItem(item)
                }
              }, (item) => JSON.stringify(item))
            }
          }
          .height(CommonConstants.FULL_LENGTH)
        }
        .width(CommonConstants.FULL_LENGTH)
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .width(CommonConstants.FULL_LENGTH)
      .height(CommonConstants.FULL_LENGTH)
      .margin({ top: 10, left: 20, right: 20 })
      .onTouch((event?: TouchEvent) => {
        this.pullDownRefresh(event);
      })
    }
  }

  pullDownRefresh(event?: TouchEvent): void {
    if (event === undefined) {
      return;
    }
    switch (event.type) {
      case TouchType.Down:
        this.currentOffsetY = event.touches[0].y;
        break;
      case TouchType.Move:
        this.isRefresh = event.touches[0].y - this.currentOffsetY > 100;
        break;
      case TouchType.Cancel:
        break;
      case TouchType.Up:
        this.getData()
        break;
    }
  }
}