import CommonConstants from '../../common/CommonConstants';
import { PlayConstants } from '../../common/PlayConstants';
import { VideoController } from '../../controller/VideoController';


@Component
export struct PlayControl {
  private playVideoModel?: VideoController;
  @Consume status: number;

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_previous'))
          .width($r('app.float.control_image_width'))
          .aspectRatio(PlayConstants.ASPECT_RATIO)
          .onClick(async () => {
            if (this.playVideoModel !== null) {
              this.playVideoModel!.previousVideo();
            }
            this.status = PlayConstants.STATUS_START;
          })
        Column() {
          Image(this.status === PlayConstants.STATUS_START ?
          $r('app.media.ic_pause') : $r('app.media.ic_play'))
            .width($r('app.float.control_image_width'))
            .aspectRatio(PlayConstants.ASPECT_RATIO)
            .onClick(async () => {
              if (this.playVideoModel !== null) {
                let curStatus = (this.playVideoModel!.getStatus() === PlayConstants.STATUS_START);
                this.status = curStatus ? PlayConstants.STATUS_PAUSE : PlayConstants.STATUS_START;
                this.playVideoModel!.switchPlayOrPause();
              }
            })
        }
        .layoutWeight(1)


        Image($r('app.media.ic_next'))
          .width($r('app.float.control_image_width'))
          .aspectRatio(PlayConstants.ASPECT_RATIO)
          .onClick(() => {
            if (this.playVideoModel !== null) {
              this.playVideoModel!.nextVideo();
            }
            this.status = PlayConstants.STATUS_START;
          })
      }
      .width(PlayConstants.CONTROL_ROW_WIDTH)
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .justifyContent(FlexAlign.Center)
  }
}