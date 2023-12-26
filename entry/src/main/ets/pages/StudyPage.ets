import resourceManager from '@ohos.resourceManager';
import CommonConstants from '../common/CommonConstants'
import { PlayConstants } from '../common/PlayConstants';
import { VideoController } from '../controller/VideoController';
import { getYesApiTable } from '../http/apiService';
import { PlayerModel } from '../model/PlayerModel';
import { LogUtils } from '../utils/LogUtils';
import { PlayControl } from '../view/player/PlayControl';
import { PlayPlayer } from '../view/player/PlayPlayer';
import { PlayProgress } from '../view/player/PlayProgress';
import { PlayTitle } from '../view/player/PlayTitle';

@Component
export struct StudyPage {
  @Provide playerModel: PlayerModel = new PlayerModel();
  @Provide src: resourceManager.RawFileDescriptor = {} as resourceManager.RawFileDescriptor;
  @Provide iSrc: string = '';
  @Provide index: number = 0;
  @Provide type: number = 0;
  @Provide status: number = PlayConstants.STATUS_START;
  playVideoModel: VideoController = new VideoController(this.playerModel);
  private panOptionBright: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.Vertical });
  private panOptionVolume: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.Horizontal });

  aboutToAppear() {
    getYesApiTable("GlobalConfig", "3").then(result => {
      let url = result.data.data.playUrl
      this.iSrc = url
    })
  }

  aboutToDisappear() {
    this.playVideoModel.release();
  }

  onPageHide() {
    this.status = PlayConstants.STATUS_PAUSE;
    this.playVideoModel.pause();
    LogUtils.warn("chenchen onPageHide")
  }

  build() {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Stack() {
        Column() {
          Column() {
          }
          .height(this.playerModel.videoMargin)

          PlayPlayer({ playVideoModel: this.playVideoModel })
            .width(this.playerModel.videoWidth)
            .height(this.playerModel.videoHeight)
        }
        .height(CommonConstants.FULL_LENGTH)
        .width(CommonConstants.FULL_LENGTH)
        .justifyContent(this.playerModel.videoPosition)
        .zIndex(0)

        Column() {
          PlayTitle({ playVideoModel: this.playVideoModel })
            .width(CommonConstants.FULL_LENGTH)
            .height(PlayConstants.HEIGHT)
          Column()
            .width(CommonConstants.FULL_LENGTH)
            .height(PlayConstants.COLUMN_HEIGHT_ONE)
            .gesture(
              PanGesture(this.panOptionBright)
                .onActionStart((event?: GestureEvent) => {
                  this.playVideoModel.onBrightActionStart(event);
                })
                .onActionUpdate((event?: GestureEvent) => {
                  this.playVideoModel.onBrightActionUpdate(event);
                })
                .onActionEnd(() => {
                  this.playVideoModel.onActionEnd();
                })
            )
          Column() {
          }
          .width(CommonConstants.FULL_LENGTH)
          .height(PlayConstants.PLAY_PLAYER_HEIGHT)

          Column()
            .width(CommonConstants.FULL_LENGTH)
            .height(PlayConstants.COLUMN_HEIGHT_TWO)
            .gesture(
              PanGesture(this.panOptionVolume)
                .onActionStart((event?: GestureEvent) => {
                  this.playVideoModel.onVolumeActionStart(event);
                })
                .onActionUpdate((event?: GestureEvent) => {
                  this.playVideoModel.onVolumeActionUpdate(event);
                })
                .onActionEnd(() => {
                  this.playVideoModel.onActionEnd();
                })
            )
          PlayControl({ playVideoModel: this.playVideoModel })
            .width(CommonConstants.FULL_LENGTH)
            .height(PlayConstants.HEIGHT)
          PlayProgress({ playVideoModel: this.playVideoModel })
            .width(CommonConstants.FULL_LENGTH)
            .height(PlayConstants.PLAY_PROGRESS_HEIGHT)
        }
        .height(CommonConstants.FULL_LENGTH)
        .width(CommonConstants.FULL_LENGTH)
        .zIndex(1)
      }
      .height(CommonConstants.FULL_LENGTH)
      .width(CommonConstants.FULL_LENGTH)
      .backgroundColor(Color.Black)
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}