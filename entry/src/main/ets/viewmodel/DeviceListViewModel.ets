import { getDeviceList } from '../http/apiService'
import { BaseViewModel, ResultCallback } from './BaseViewModel'

export class DeviceListViewMode extends BaseViewModel {
  getDeviceList(token?: string, resultCallback?: ResultCallback) {
    getDeviceList(token).then(result => resultCallback?.(result))
  }
}

export default new DeviceListViewMode()