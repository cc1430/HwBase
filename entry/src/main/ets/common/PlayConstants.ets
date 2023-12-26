/**
 * Play constants for all features.
 */
import resourceManager from '@ohos.resourceManager';
import { VideoItem } from '../model/VideoItem';
import { VideoSpeed } from '../model/VideoSpeed';
export class PlayConstants {
  /**
   * Playback page constant.
   */
  static readonly PLAY_SPEED: number = 1;
  static readonly VOLUME: number = 0.5;
  static readonly VOLUME_SHOW: boolean = false;
  static readonly BRIGHT: number = 0.5;
  static readonly BRIGHT_SHOW: boolean = false;
  static readonly POSITION_X: number = 0;
  static readonly POSITION_Y: number = 0;
  static readonly HEIGHT: string = '7.2%';
  static readonly PLAY_PLAYER_HEIGHT: string = '25.6%';
  static readonly PLAY_PLAYER_HEIGHT_FULL: string = '75.4%';
  static readonly PLAY_PROGRESS_HEIGHT: string = '7.1%';
  static readonly COLUMN_HEIGHT_ONE: string = '26.9%';
  static readonly COLUMN_HEIGHT_TWO: string = '22.9%';
  static readonly MIN_ANGLE: number = 0;
  static readonly MAX_ANGLE: number = 30;
  static readonly MIN_VALUE: number = 0;
  static readonly MAX_VALUE: number = 1;
  static readonly DISAPPEAR_TIME: number = 200;
  static readonly MARGIN_ZERO: string = '0';
  /**
   * Playback Page Header Constant.
   */
  static readonly DX: number = 0;
  static readonly DY: number = -20;
  static readonly GRID_COUNT: number = 4;
  static readonly TEXT_MARGIN_LEFT: string = '4.4%';
  static readonly ROW_WIDTH: string = '86.6%';
  static readonly POPUP_ROW_HEIGHT: string = '45.3%';
  static readonly POPUP_ROW_MARGIN_TOP: string = '3.8%';
  static readonly POPUP_DIVIDER_STROKE_WIDTH: number = 1;
  static readonly POPUP_DIVIDER_MARGIN_RIGHT: string = '10.2%';
  static readonly POPUP_COLUMN_WIDTH: string = '43.3%';
  static readonly POPUP_COLUMN_HEIGHT: string = '13.5%';
  static readonly POPUP_CLOSE_TIME: number = 500;
  /**
   * Constants for setting the playback speed.
   */
  static readonly TITLE_DIALOG_ROW_HEIGHT: string = '25%';
  static readonly TITLE_DIALOG_ROW_WIDTH: string = '86.6%';
  static readonly TITLE_DIALOG_COLUMNS_TEMPLATE: string = '1fr 1fr 1fr';
  static readonly TITLE_DIALOG_ROWS_TEMPLATE: string = '1fr 1fr';
  static readonly TITLE_DIALOG_COLUMNS_GAP: number = 10;
  static readonly TITLE_DIALOG_ROWS_GAP: number = 10;
  static readonly TITLE_DIALOG_COLUMN_WIDTH: string = '39.2%';
  /**
   * Video playback constant.
   */
  static readonly PLAYER_ID: string = '';
  static readonly PLAYER_TYPE: string = 'surface';
  static readonly PLAYER_LIBRARY_NAME: string = '';
  static readonly PLAYER_SURFACE_WIDTH: number = 1920;
  static readonly PLAYER_SURFACE_HEIGHT: number = 1080;
  static readonly PLAYER_STACK_WIDTH: string = '16.7%';
  static readonly PLAYER_IMAGE_WIDTH: string = '95%';
  static readonly PLAYER_FIRST: number = 0;
  static readonly PLAYER_NEXT: number = 1;
  static readonly PLAYER_DURATION: number = 0;
  /**
   * Video playback control constant.
   */
  static readonly CONTROL_ROW_WIDTH: string = '68.8%';
  static readonly CONTROL_PLAY_START: number = 1;
  static readonly CONTROL_PLAY_PAUSE: number = 2;
  static readonly CONTROL_NEXT: number = 1;
  static readonly CONTROL_FIRST: number = 0;
  /**
   * Progress bar page constant.
   */
  static readonly PROGRESS_CURRENT_TIME: string = '00:00';
  static readonly PROGRESS_TOTAL_TIME: string = '00:00';
  static readonly PROGRESS_PROGRESS_VAL: number = 0;
  static readonly PROGRESS_INTERVAL: number = -1;
  static readonly PROGRESS_STEP: number = 1;
  static readonly PROGRESS_TRACK_THICKNESS: number = 1;
  static readonly PROGRESS_SLIDER_WIDTH: string = '68.9%';
  static readonly PROGRESS_MARGIN_LEFT: string = '2.2%';
  static readonly PROGRESS_SEEK_TIME: number = 0;
  static readonly PROGRESS_ROW_WIDTH: string = '93.4%';
  /**
   * Network video playback error notification duration
   */
  static readonly PLAY_ERROR_TIME: number = 3000;

  /**
   * Start playing.
   */
  static readonly STATUS_START: number = 1;
  /**
   * Playing Pause.
   */
  static readonly STATUS_PAUSE: number = 2;
  /**
   * Stop Playing.
   */
  static readonly STATUS_STOP: number = 3;
  /**
   * Width-height ratio.
   */
  static readonly ASPECT_RATIO: number = 1;

  /**
   * Speed set.
   */
  static readonly SPEED_ARRAY: VideoSpeed[] = [
    new VideoSpeed('0.75X', 0),
    new VideoSpeed('1.0X', 1),
    new VideoSpeed('1.25X', 2),
    new VideoSpeed('1.75X', 3),
    new VideoSpeed('2.0X', 4)
  ];

  /**
   * Operation status of video player 4.
   */
  static readonly OPERATE_STATE: Array<string> = ['prepared', 'playing', 'paused', 'completed'];
}

/**
 * Player component status.
 */
export enum AvplayerStatus {
  IDLE = 'idle',
  INITIALIZED = 'initialized',
  PREPARED = 'prepared',
  PLAYING = 'playing',
  PAUSED = 'paused',
  COMPLETED = 'completed',
  STOPPED = 'stopped',
  RELEASED = 'released',
  ERROR = 'error'
}

/**
 * AVPlayer binding event.
 */
export enum Events {
  STATE_CHANGE = 'stateChange',
  TIME_UPDATE = 'timeUpdate',
  ERROR = 'error'
}

/**
 * Slider mode.
 */
export enum SliderMode {
  MOVING = 1,
  END = 2,
  CLICK = 3
}

/**
 * Video object collection.
 */
export const VIDEO_DATA: VideoItem[] = [
  new VideoItem('video1', {} as resourceManager.RawFileDescriptor, 'video1.mp4',),
  new VideoItem('video2', {} as resourceManager.RawFileDescriptor, 'video2.mp4',)
]