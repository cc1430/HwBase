import CommonConstants from '../../common/CommonConstants';
import { PlayConstants } from '../../common/PlayConstants';
import { VideoController } from '../../controller/VideoController';
import { PlayerModel } from '../../model/PlayerModel';

@Component
export struct PlayProgress {
  private playVideoModel?: VideoController;
  @Consume playerModel: PlayerModel;

  build() {
    Column() {
      Row() {
        Text(this.playerModel.currentTime)
          .fontSize($r('app.float.slider_font_size'))
          .fontColor(Color.White)
        Slider({
          value: this.playerModel.progressVal,
          step: PlayConstants.PROGRESS_STEP,
          style: SliderStyle.OutSet
        })
          .blockColor(Color.White)
          .trackColor($r('app.color.grey_888888'))
          .selectedColor(Color.White)
          .trackThickness(PlayConstants.PROGRESS_TRACK_THICKNESS)
          .layoutWeight(1)
          .margin({ left: PlayConstants.PROGRESS_MARGIN_LEFT })
          .onChange((value: number, mode: SliderChangeMode) => {
            this.playVideoModel!.setSeekTime(value, mode);
          })
        Text(this.playerModel.totalTime)
          .fontSize($r('app.float.slider_font_size'))
          .fontColor(Color.White)
          .margin({ left: PlayConstants.PROGRESS_MARGIN_LEFT })
      }
      .width(PlayConstants.PROGRESS_ROW_WIDTH)
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .justifyContent(FlexAlign.Center)
  }
}