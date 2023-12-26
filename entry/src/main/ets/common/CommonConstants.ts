/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * Style constants that can be used by all modules
 */
export default class CommonConstants {
  /**
   * Full width or height.
   */
  static readonly FULL_LENGTH: string = '100%';

  /**
   * Title height.
   */
  static readonly TITLE_WIDTH: string = '80%';

  /**
   * List default width.
   */
  static readonly LIST_DEFAULT_WIDTH: string = '93.3%';

  /**
   * Opacity of default.
   */
  static readonly OPACITY_DEFAULT: number = 1;

  /**
   * Opacity of default.
   */
  static readonly OPACITY_COMPLETED: number = 0.4;

  /**
   * BorderRadius of list item.
   */
  static readonly BORDER_RADIUS: number = 24;

  /**
   * BorderRadius of list item.
   */
  static readonly FONT_WEIGHT: number = 500;

  /**
   * Space of column.
   */
  static readonly COLUMN_SPACE: number = 16;

  /**
   * time system, Hour-minute-second conversion.
   */
  static readonly TIME_UNIT: number = 60;

  /**
   * Initial Time UNIT.
   */
  static readonly INITIAL_TIME_UNIT: string = '00';

  /**
   * Zero padding, 2 bits.
   */
  static readonly PADDING_LENGTH: number = 2;

  /**
   * String zero padding.
   */
  static readonly PADDING_STR: string = '0';

  /**
   * Width-height ratio.
   */
  static readonly ASPECT_RATIO: number = 1;
  /**
   * One hundred.
   */
  static readonly ONE_HUNDRED: number = 100;
  /**
   * A thousand.
   */
  static readonly A_THOUSAND: number = 1000;

  /**
   * agents data.
   */
  static readonly TODO_DATA: Array<string> = [
    "早起晨练",
    "准备早餐",
    "阅读名著",
    "学习ArkTS",
    "看剧放松",
    "早起晨练",
    "准备早餐",
    "阅读名著",
    "学习ArkTS",
    "看剧放松",
    "早起晨练",
    "准备早餐",
    "阅读名著",
    "学习ArkTS",
    "看剧放松"
  ];

  static readonly SMART_HOME_BASE_URL = "https://iot-test.wasumedia.cn/"
  static readonly SMART_HOME_CLIENT_ID = "wasu.client.app.9f3f1a65d6c35df1"
  static readonly SMART_HOME_CLIENT_SECRET = "78adc40a9a74f5de75da619ba63b4edf"
}

