import Window from '@ohos.window';
import { GlobalContext } from './GlobalContext';
import { LogUtils } from './LogUtils';

class ScreenUtil {
  setScreenSize(): void {
    Window.getLastWindow(getContext(this))
      .then((windowClass: Window.Window) => {
        let screenWidth = px2fp(windowClass.getWindowProperties().windowRect.width);
        let screenHeight = px2fp(windowClass.getWindowProperties().windowRect.height);
        GlobalContext.getContext().setObject('screenWidth', screenWidth);
        GlobalContext.getContext().setObject('screenHeight', screenHeight);
        GlobalContext.getContext().setObject('windowClass', windowClass);
      })
      .catch((error: Error) => {
        LogUtils.error('[ScreenUtil] Failed to obtain the window size. Cause: ' + JSON.stringify(error));
      })
  }
}

export default new ScreenUtil();
