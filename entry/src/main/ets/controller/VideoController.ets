/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import media from '@ohos.multimedia.media';
import prompt from '@ohos.promptAction';
import window from '@ohos.window';
import resourceManager from '@ohos.resourceManager';
import { AvplayerStatus, Events, PlayConstants, SliderMode } from '../common/PlayConstants';
import DateFormatUtil from '../utils/DateFormatUtil';
import { LogUtils } from '../utils/LogUtils';
import CommonConstants from '../common/CommonConstants';
import { VideoItem } from '../model/VideoItem';
import { PlayerModel } from '../model/PlayerModel';
import { GlobalContext } from '../utils/GlobalContext';

@Observed
export class VideoController {
  public playerModel: PlayerModel;
  private avPlayer: media.AVPlayer | null = null;
  private duration: number = 0;
  private status: number = -1;
  private loop: boolean = false;
  private index: number = 0;
  private url?: resourceManager.RawFileDescriptor = {} as resourceManager.RawFileDescriptor;
  private iUrl: string = '';
  private surfaceId: string = '';
  private seekTime: number = PlayConstants.PROGRESS_SEEK_TIME;
  private positionX: number = PlayConstants.POSITION_X;
  private positionY: number = PlayConstants.POSITION_Y;

  constructor(playerModel: PlayerModel) {
    this.playerModel = playerModel;
    this.createAVPlayer();
  }

  /**
   * Creates a videoPlayer object.
   */
  async createAVPlayer() {
    let avPlayer: media.AVPlayer = await media.createAVPlayer();
    this.avPlayer = avPlayer;
    this.bindState();
  }

  /**
   * AVPlayer binding event.
   */
  async bindState() {
    if (this.avPlayer === null) {
      return;
    }
    this.avPlayer.on(Events.STATE_CHANGE, async (state: media.AVPlayerState) => {
      LogUtils.debug("player state = " + state)
      let avplayerStatus: string = state;
      if (this.avPlayer === null) {
        return;
      }
      switch (avplayerStatus) {
        case AvplayerStatus.IDLE:
          this.resetProgress();
          if (this.iUrl) {
            this.avPlayer.url = this.iUrl;
          } else {
            this.avPlayer.fdSrc = this.url;
          }
          break;
        case AvplayerStatus.INITIALIZED:
          this.avPlayer.surfaceId = this.surfaceId;
          this.avPlayer.prepare();
          break;
        case AvplayerStatus.PREPARED:
          this.avPlayer.videoScaleType = 0;
          this.setVideoSize();
          this.avPlayer.play();
          this.duration = this.avPlayer.duration;
          break;
        case AvplayerStatus.PLAYING:
          this.avPlayer.setVolume(this.playerModel.volume);
          this.setBright();
          this.status = PlayConstants.STATUS_START;
          this.watchStatus();
          break;
        case AvplayerStatus.PAUSED:
          this.status = PlayConstants.STATUS_PAUSE;
          this.watchStatus();
          break;
        case AvplayerStatus.COMPLETED:
          this.playerModel.playSpeed = PlayConstants.PLAY_SPEED;
          this.duration = PlayConstants.PLAYER_DURATION;
          if (!this.loop) {
            let curIndex = this.index + PlayConstants.PLAYER_NEXT;
            let globalVideoList = GlobalContext.getContext().getObject('globalVideoList') as VideoItem[];
            this.index = (curIndex === globalVideoList.length) ?
            PlayConstants.PLAYER_FIRST : curIndex;
            if (this.iUrl) {
              this.iUrl = globalVideoList[this.index].iSrc;
            } else {
              this.url = globalVideoList[this.index].src;
            }
          }
          this.avPlayer.reset();
          break;
        case AvplayerStatus.RELEASED:
          this.avPlayer.release();
          this.status = PlayConstants.STATUS_STOP;
          this.watchStatus();
          LogUtils.info('[PlayVideoModel] state released called')
          break;
        default:
          LogUtils.info('[PlayVideoModel] unKnown state: ' + state);
          break;
      }
    });
    this.avPlayer.on(Events.TIME_UPDATE, (time: number) => {
      this.initProgress(time);
    });
    this.avPlayer.on(Events.ERROR, () => {
      this.playError();
    })
  }

  /**
   * This method is triggered when the video playback page is displayed on the video list page.
   *
   * @param index Video object subscript in the video list.
   * @param url Playback Path.
   * @param surfaceId Indicates the surface ID of the surfaceId.
   */
  async firstPlay(index: number, url: resourceManager.RawFileDescriptor, iUrl: string, surfaceId: string) {
    this.index = index;
    this.url = url;
    this.iUrl = iUrl;
    this.surfaceId = surfaceId;
    if (this.avPlayer === null) {
      await this.createAVPlayer();
    }
    if (this.avPlayer !== null) {
      if (this.iUrl) {
        this.avPlayer.url = this.iUrl;
      } else {
        this.avPlayer.fdSrc = this.url;
      }
    }
  }

  /**
   * Release the video player.
   */
  release() {
    if (this.avPlayer !== null) {
      this.avPlayer.release();
    }
  }

  /**
   * Pause Playing.
   */
  pause() {
    if (this.avPlayer !== null) {
      this.avPlayer.pause();
    }
  }

  /**
   * Playback mode. The options are as follows: true: playing a single video; false: playing a cyclic video.
   */
  setLoop() {
    this.loop = !this.loop;
  }

  /**
   * Set the playback speed.
   *
   * @param playSpeed Current playback speed.
   */
  setSpeed(playSpeed: number) {
    if (this.avPlayer === null) {
      return;
    }
    if (PlayConstants.OPERATE_STATE.indexOf(this.avPlayer.state) === -1) {
      return;
    }
    this.playerModel.playSpeed = playSpeed;
    this.avPlayer.setSpeed(this.playerModel.playSpeed);
  }

  /**
   * Previous video.
   */
  previousVideo() {
    if (this.avPlayer === null) {
      return;
    }
    if (PlayConstants.OPERATE_STATE.indexOf(this.avPlayer.state) === -1) {
      return;
    }
    this.playerModel.playSpeed = PlayConstants.PLAY_SPEED;
    let globalVideoList = GlobalContext.getContext().getObject('globalVideoList') as VideoItem[];
    let curIndex = this.index - PlayConstants.CONTROL_NEXT;
    this.index = (curIndex === -PlayConstants.CONTROL_NEXT) ?
      (globalVideoList.length - PlayConstants.CONTROL_NEXT) : curIndex;
    if (this.iUrl) {
      this.iUrl = globalVideoList[this.index].iSrc;
    } else {
      this.url = globalVideoList[this.index].src;
    }
    this.avPlayer.reset();
  }

  /**
   * Next video.
   */
  nextVideo() {
    if (this.avPlayer === null) {
      return;
    }
    if (PlayConstants.OPERATE_STATE.indexOf(this.avPlayer.state) === -1) {
      return;
    }
    this.playerModel.playSpeed = PlayConstants.PLAY_SPEED;
    let globalVideoList = GlobalContext.getContext().getObject('globalVideoList') as VideoItem[];
    let curIndex = this.index + PlayConstants.CONTROL_NEXT;
    this.index = (curIndex === globalVideoList.length) ?
    PlayConstants.CONTROL_FIRST : curIndex;
    if (this.iUrl) {
      this.iUrl = globalVideoList[this.index].iSrc;
    } else {
      this.url = globalVideoList[this.index].src;
    }
    this.avPlayer.reset();
  }

  /**
   * Switching Between Video Play and Pause.
   */
  switchPlayOrPause() {
    if (this.avPlayer === null) {
      return;
    }
    if (this.status === PlayConstants.STATUS_START) {
      this.avPlayer.pause();
    } else {
      this.avPlayer.play();
    }
  }

  /**
   * Slide the progress bar to set the playback progress.
   *
   * @param value Value of the slider component.
   * @param mode Slider component change event.
   */
  setSeekTime(value: number, mode: SliderChangeMode) {
    if (mode === Number(SliderMode.MOVING)) {
      this.playerModel.progressVal = value;
      this.playerModel.currentTime = DateFormatUtil.secondToTime(Math.floor(value * this.duration /
      CommonConstants.ONE_HUNDRED / CommonConstants.A_THOUSAND));
    }
    if (mode === Number(SliderMode.END) || mode === Number(SliderMode.CLICK)) {
      this.seekTime = value * this.duration / CommonConstants.ONE_HUNDRED;
      if (this.avPlayer !== null) {
        this.avPlayer.seek(this.seekTime, media.SeekMode.SEEK_PREV_SYNC);
      }
    }
  }

  /**
   * Setting the brightness.
   */
  setBright() {
    let windowClass = GlobalContext.getContext().getObject('windowClass') as window.Window;
    windowClass.setWindowBrightness(this.playerModel.bright);
  }

  /**
   * Obtains the current video playing status.
   */
  getStatus() {
    return this.status;
  }

  /**
   * Initialization progress bar.
   *
   * @param time Current video playback time.
   */
  initProgress(time: number) {
    let nowSeconds = Math.floor(time / CommonConstants.A_THOUSAND);
    let totalSeconds = Math.floor(this.duration / CommonConstants.A_THOUSAND);
    this.playerModel.currentTime = DateFormatUtil.secondToTime(nowSeconds);
    this.playerModel.totalTime = DateFormatUtil.secondToTime(totalSeconds);
    this.playerModel.progressVal = Math.floor(nowSeconds * CommonConstants.ONE_HUNDRED / totalSeconds);
  }

  /**
   * Reset progress bar data.
   */
  resetProgress() {
    this.seekTime = PlayConstants.PROGRESS_SEEK_TIME;
    this.playerModel.currentTime = PlayConstants.PROGRESS_CURRENT_TIME;
    this.playerModel.progressVal = PlayConstants.PROGRESS_PROGRESS_VAL;
  }

  /**
   * Volume gesture method onActionStart.
   *
   * @param event Gesture event.
   */
  onVolumeActionStart(event?: GestureEvent) {
    if (!event) {
      return;
    }
    this.positionX = event.offsetX;
  }

  /**
   * Bright gesture method onActionStart.
   *
   * @param event Gesture event.
   */
  onBrightActionStart(event?: GestureEvent) {
    if (!event) {
      return;
    }
    this.positionY = event.offsetY;
  }

  /**
   * Gesture method onActionUpdate.
   *
   * @param event Gesture event.
   */
  onVolumeActionUpdate(event?: GestureEvent) {
    if (!event) {
      return;
    }
    if (this.avPlayer === null) {
      return;
    }
    if (PlayConstants.OPERATE_STATE.indexOf(this.avPlayer.state) === -1) {
      return;
    }
    if (this.playerModel.brightShow === false) {
      this.playerModel.volumeShow = true;
      let screenWidth = GlobalContext.getContext().getObject('screenWidth') as number;
      let changeVolume = (event.offsetX - this.positionX) / screenWidth;
      let volume: number = this.playerModel.volume;
      let currentVolume = volume + changeVolume;
      let volumeMinFlag = currentVolume <= PlayConstants.MIN_VALUE;
      let volumeMaxFlag = currentVolume > PlayConstants.MAX_VALUE;
      this.playerModel.volume = volumeMinFlag ? PlayConstants.MIN_VALUE :
        (volumeMaxFlag ? PlayConstants.MAX_VALUE : currentVolume);
      this.avPlayer.setVolume(this.playerModel.volume);
      this.positionX = event.offsetX;
    }
  }

  /**
   * Gesture method onActionUpdate.
   *
   * @param event Gesture event.
   */
  onBrightActionUpdate(event?: GestureEvent) {
    if (!event) {
      return;
    }
    if (this.playerModel.volumeShow === false) {
      this.playerModel.brightShow = true;
      let screenHeight = GlobalContext.getContext().getObject('screenHeight') as number;
      let changeBright = (this.positionY - event.offsetY) / screenHeight;
      let bright: number = this.playerModel.bright;
      let currentBright = bright + changeBright;
      let brightMinFlag = currentBright <= PlayConstants.MIN_VALUE;
      let brightMaxFlag = currentBright > PlayConstants.MAX_VALUE;
      this.playerModel.bright = brightMinFlag ? PlayConstants.MIN_VALUE :
        (brightMaxFlag ? PlayConstants.MAX_VALUE : currentBright);
      this.setBright();
      this.positionY = event.offsetY;
    }
  }

  /**
   * Gesture method onActionEnd.
   */
  onActionEnd() {
    setTimeout(() => {
      this.playerModel.volumeShow = false;
      this.playerModel.brightShow = false;
      this.positionX = PlayConstants.POSITION_X;
      this.positionY = PlayConstants.POSITION_Y;
    }, PlayConstants.DISAPPEAR_TIME);
  }

  /**
   * Sets whether the screen is a constant based on the playback status.
   */
  watchStatus() {
    let windowClass = GlobalContext.getContext().getObject('windowClass') as window.Window;
    if (this.status === PlayConstants.STATUS_START) {
      windowClass.setWindowKeepScreenOn(true);
    } else {
      windowClass.setWindowKeepScreenOn(false);
    }
  }

  /**
   * Sets the playback page size based on the video size.
   */
  setVideoSize() {
    if (this.avPlayer === null) {
      return;
    }
    if (this.avPlayer.height > this.avPlayer.width) {
      this.playerModel.videoWidth = PlayConstants.PLAY_PLAYER_HEIGHT_FULL;
      this.playerModel.videoHeight = PlayConstants.PLAY_PLAYER_HEIGHT_FULL;
      this.playerModel.videoPosition = FlexAlign.Start;
      this.playerModel.videoMargin = PlayConstants.HEIGHT;
    } else {
      this.playerModel.videoWidth = CommonConstants.FULL_LENGTH;
      this.playerModel.videoHeight = PlayConstants.PLAY_PLAYER_HEIGHT;
      this.playerModel.videoPosition = FlexAlign.Center;
      this.playerModel.videoMargin = PlayConstants.MARGIN_ZERO;
    }
  }

  /**
   * An error is reported during network video playback.
   */
  playError() {
    prompt.showToast({
      duration: PlayConstants.PLAY_ERROR_TIME,
      message: $r('app.string.link_check_address_internet')
    });
  }
}