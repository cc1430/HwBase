
import CommonConstants from '../../common/CommonConstants'
import { uuid } from '../../utils/signUtils'
export class SystemBean{
  requestId: string = uuid()
  clientId: string = CommonConstants.SMART_HOME_CLIENT_ID
  accessToken: string
  sign: string
  signVersion: number = 4
  apiVersion: number = 4
  ts: number = new Date().getTime()
}