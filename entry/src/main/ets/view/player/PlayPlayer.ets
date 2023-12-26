import resourceManager from '@ohos.resourceManager';
import CommonConstants from '../../common/CommonConstants';
import { PlayConstants } from '../../common/PlayConstants';
import { VideoController } from '../../controller/VideoController';
import { PlayerModel } from '../../model/PlayerModel';

@Component
export struct PlayPlayer {
  private playVideoModel?: VideoController;
  @Consume playerModel: PlayerModel;
  @Consume src: resourceManager.RawFileDescriptor;
  @Consume iSrc: string;
  @Consume index: number;
  private xComponentController = new XComponentController();
  private surfaceID: string = '';

  build() {
    Stack() {
      XComponent({
        id: PlayConstants.PLAYER_ID,
        type: PlayConstants.PLAYER_TYPE,
        libraryname: PlayConstants.PLAYER_LIBRARY_NAME,
        controller: this.xComponentController
      })
        .onLoad(async () => {
          this.xComponentController.setXComponentSurfaceSize({
            surfaceWidth: PlayConstants.PLAYER_SURFACE_WIDTH,
            surfaceHeight: PlayConstants.PLAYER_SURFACE_HEIGHT
          });
          this.surfaceID = this.xComponentController.getXComponentSurfaceId();
          this.playVideoModel!.firstPlay(this.index, this.src, this.iSrc, this.surfaceID);
        })
        .width(CommonConstants.FULL_LENGTH)
        .height(CommonConstants.FULL_LENGTH)

      Stack() {
        Progress({
          value: Math.floor(this.playerModel.volume * CommonConstants.ONE_HUNDRED),
          type: ProgressType.Ring
        })
          .width(CommonConstants.FULL_LENGTH)
          .aspectRatio(CommonConstants.ASPECT_RATIO)
        Image($r('app.media.ic_volume'))
          .width(PlayConstants.PLAYER_IMAGE_WIDTH)
          .aspectRatio(CommonConstants.ASPECT_RATIO)
      }
      .width(PlayConstants.PLAYER_STACK_WIDTH)
      .aspectRatio(CommonConstants.ASPECT_RATIO)
      .visibility(this.playerModel.volumeShow ? Visibility.Visible : Visibility.Hidden)

      Stack() {
        Progress({
          value: Math.floor(this.playerModel.bright * CommonConstants.ONE_HUNDRED),
          type: ProgressType.Ring
        })
          .width(CommonConstants.FULL_LENGTH)
          .aspectRatio(CommonConstants.ASPECT_RATIO)
        Image($r('app.media.ic_brightness'))
          .width(PlayConstants.PLAYER_IMAGE_WIDTH)
          .aspectRatio(CommonConstants.ASPECT_RATIO)
      }
      .width(PlayConstants.PLAYER_STACK_WIDTH)
      .aspectRatio(CommonConstants.ASPECT_RATIO)
      .visibility(this.playerModel.brightShow ? Visibility.Visible : Visibility.Hidden)
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}