import router from '@ohos.router';
import CommonConstants from '../../common/CommonConstants';
import { PlayConstants } from '../../common/PlayConstants';
import { VideoController } from '../../controller/VideoController';
import { PlayTitleDialog } from './PlayTitleDialog';

@Component
export struct PlayTitle {
  private playVideoModel: VideoController | null = null;
  @State loop: boolean = false;
  @State customPopup: boolean = false;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: PlayTitleDialog({ playVideoModel: this.playVideoModel! }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: PlayConstants.DX, dy: PlayConstants.DY },
    gridCount: PlayConstants.GRID_COUNT,
    customStyle: false
  })

  @Builder
  popupBuilder() {
    Column() {
      Row() {
        Image($r('app.media.ic_speed'))
          .width($r('app.float.title_popup_image_size'))
          .aspectRatio(CommonConstants.ASPECT_RATIO)
          .margin({ left: $r('app.float.title_popup_image_left') })
        Text($r('app.string.speed_play'))
          .fontSize($r('app.float.title_popup_font_size'))
          .margin({ left: $r('app.float.title_popup_text_left') })
      }
      .width(CommonConstants.FULL_LENGTH)
      .height(PlayConstants.POPUP_ROW_HEIGHT)
      .margin({ top: PlayConstants.POPUP_ROW_MARGIN_TOP })
      .onClick(() => {
        this.customPopup = !this.customPopup;
        this.dialogController.open();
      })

      Row() {
        Divider()
          .strokeWidth(PlayConstants.POPUP_DIVIDER_STROKE_WIDTH)
          .color($r('app.color.grey_D3D3D3'))
          .margin({
            left: $r('app.float.title_popup_divider_left'),
            right: PlayConstants.POPUP_DIVIDER_MARGIN_RIGHT
          })
      }
      .width(CommonConstants.FULL_LENGTH)

      Row() {
        Image(this.loop ? $r('app.media.ic_single_loop') : $r('app.media.ic_sequence_play'))
          .width($r('app.float.title_popup_image_size'))
          .aspectRatio(CommonConstants.ASPECT_RATIO)
          .margin({ left: $r('app.float.title_popup_image_left') })
        Text(this.loop ? $r('app.string.monolithic_cycle') : $r('app.string.continuous_playback'))
          .fontSize($r('app.float.title_popup_font_size'))
          .margin({ left: $r('app.float.title_popup_text_left') })
      }
      .width(CommonConstants.FULL_LENGTH)
      .height(PlayConstants.POPUP_ROW_HEIGHT)
      .onClick(() => {
        this.loop = !this.loop;
        this.playVideoModel!.setLoop();
        setTimeout(() => {
          this.customPopup = !this.customPopup;
        }, PlayConstants.POPUP_CLOSE_TIME);
      })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width(PlayConstants.POPUP_COLUMN_WIDTH)
    .height(PlayConstants.POPUP_COLUMN_HEIGHT)
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.title_image_size'))
          .aspectRatio(CommonConstants.ASPECT_RATIO)
          .onClick(() => {
            router.back();
          })
        Text($r('app.string.video_playback'))
          .fontColor(Color.White)
          .fontSize($r('app.float.title_font_size'))
          .margin({ left: PlayConstants.TEXT_MARGIN_LEFT })
          .layoutWeight(1)
        Image($r('app.media.ic_more'))
          .width($r('app.float.title_image_size'))
          .aspectRatio(CommonConstants.ASPECT_RATIO)
          .bindPopup(this.customPopup, {
            builder: this.popupBuilder,
            placement: Placement.BottomRight,
            popupColor: Color.White,
            enableArrow: false
          })
          .onClick(() => {
            this.customPopup = !this.customPopup;
          })
      }
      .width(PlayConstants.ROW_WIDTH)
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .justifyContent(FlexAlign.Center)
  }
}