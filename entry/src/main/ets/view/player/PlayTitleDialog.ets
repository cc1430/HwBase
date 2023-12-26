import CommonConstants from '../../common/CommonConstants';
import { PlayConstants } from '../../common/PlayConstants';
import { VideoController } from '../../controller/VideoController';
import { VideoSpeed } from '../../model/VideoSpeed';

@CustomDialog
export struct PlayTitleDialog {
  private playVideoModel?: VideoController;
  controller?: CustomDialogController;

  build() {
    Column() {
      Row() {
        Text($r('app.string.speed_play'))
          .fontSize($r('app.float.title_font_size'))
      }
      .height(PlayConstants.TITLE_DIALOG_ROW_HEIGHT)
      .width(PlayConstants.TITLE_DIALOG_ROW_WIDTH)

      Column() {
        Grid() {
          ForEach(PlayConstants.SPEED_ARRAY, (item: VideoSpeed) => {
            GridItem() {
              Text(item.text)
                .fontSize($r('app.float.title_dialog_font_size'))
                .backgroundColor($r('app.color.grey_DDDDDD'))
                .width(CommonConstants.FULL_LENGTH)
                .height(CommonConstants.FULL_LENGTH)
                .textAlign(TextAlign.Center)
                .borderRadius($r('app.float.text_border_radius'))
            }
            .onClick(() => {
              this.playVideoModel!.setSpeed(item.value);
              this.controller!.close();
            })
          }, (item: VideoSpeed) => JSON.stringify(item))
        }
        .columnsTemplate(PlayConstants.TITLE_DIALOG_COLUMNS_TEMPLATE)
        .rowsTemplate(PlayConstants.TITLE_DIALOG_ROWS_TEMPLATE)
        .columnsGap(PlayConstants.TITLE_DIALOG_COLUMNS_GAP)
        .rowsGap(PlayConstants.TITLE_DIALOG_ROWS_GAP)
        .width(PlayConstants.TITLE_DIALOG_ROW_WIDTH)
        .height(CommonConstants.FULL_LENGTH)
      }
      .height(CommonConstants.FULL_LENGTH)

      Row() {
        Text($r('app.string.cancel'))
          .fontColor($r('app.color.blue_007DFF'))
          .fontSize($r('app.float.title_dialog_font_size'))
      }
      .height(PlayConstants.TITLE_DIALOG_ROW_HEIGHT)
      .width(PlayConstants.TITLE_DIALOG_ROW_WIDTH)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.controller!.close();
      })
    }
    .height(PlayConstants.TITLE_DIALOG_COLUMN_WIDTH)
    .width(CommonConstants.FULL_LENGTH)
    .backgroundColor(Color.White)
  }
}