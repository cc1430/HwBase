
import CommonConstants from '../common/CommonConstants';
@Component
export default struct PullDownRefresh {
  @Link refreshText: Resource;

  build() {
    Row() {
      Image($r('app.media.refreshing'))
        .width(40)
        .height(40)
      Text(this.refreshText).fontSize(16)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .width(CommonConstants.FULL_LENGTH)
    .height(100)
  }
}