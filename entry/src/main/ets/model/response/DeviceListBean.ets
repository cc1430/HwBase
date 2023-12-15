import List from '@ohos.util.List'
import { DeviceInfoBean } from './DeviceInfoBean'
import { RoomBean } from './RoomBean'

export class DeviceListBean {
  rooms: List<RoomBean>
  devices: List<DeviceInfoBean>
}