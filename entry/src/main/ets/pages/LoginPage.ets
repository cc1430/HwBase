import router from '@ohos.router'
import CommonConstants from '../common/CommonConstants'
import showToast from '../utils/ToastUtils'
import PreferencesUtils from '../utils/PreferencesUtils'
import LoginViewModel from '../viewmodel/LoginViewModel'

@Entry
@Component
struct LoginPage {
  /**
   * yp:15857185734
   * ws:18248461558
   */
  @State userName: string = "15857185734"
  password: string

  aboutToAppear() {
    PreferencesUtils.createPreferences(getContext(this))
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Text('您好')
        .margin({ left: 44, top: 80 })
        .fontColor($r('app.color.black_2C2C2C'))
        .fontSize(26)

      Text('欢迎登录123456')
        .margin({ left: 44, top: 4 })
        .fontColor($r('app.color.black_2C2C2C'))
        .fontSize(20)

      Column() {
        TextInput({ placeholder: "请输入手机号", text: this.userName })
          .placeholderColor($r('app.color.grey_C2C2C2'))
          .placeholderFont({ size: 16 })
          .maxLength(11)
          .fontSize(16)
          .fontColor($r('app.color.black_2C2C2C'))
          .type(InputType.PhoneNumber)
          .height(50)
          .onChange((value) => {
            this.userName = value
          })

        TextInput({ placeholder: "请输入密码" })
          .placeholderColor($r('app.color.grey_C2C2C2'))
          .placeholderFont({ size: 16 })
          .fontSize(16)
          .fontColor($r('app.color.black_2C2C2C'))
          .type(InputType.Password)
          .margin({ top: 20 })
          .height(50)
          .onChange((value) => {
            this.password = value
          })

        Button("登录")
          .width(CommonConstants.FULL_LENGTH)
          .margin({ top: 80 })
          .onClick(() => {
            LoginViewModel.doLogin(this.userName, result => {
              if (result.system.code == 0) {
                PreferencesUtils.putString("access_token", result.result.accessToken)
                PreferencesUtils.putString("phone", this.userName)
                router.replaceUrl({ url: "pages/MainPage" })
              } else {
                showToast(result.system.msg)
              }
            })
          })
      }.margin({ left: 30, top: 100, right: 30 })
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundImage($r('app.media.module_login_bg_app_show'))
    .backgroundImageSize({ width: CommonConstants.FULL_LENGTH, height: CommonConstants.FULL_LENGTH })
  }
}