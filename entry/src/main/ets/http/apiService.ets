import axiosClient from './AxiosRequest'
import { UserBean } from '../model/request/UserBean'
import { RequestBaseBean } from '../model/request/RequestBaseBean'
import { SystemBean } from '../model/request/SystemBean'
import CommonConstants from '../common/CommonConstants'
import { generateMD5Sign } from '../utils/signUtils'
import { RespBaseBean } from '../model/response/RespBaseBean'
import { LoginBean } from '../model/response/LoginBean'
import { YesApiReqBean } from '../model/request/YesApiReqBean'
import YesApiConstants from '../common/YesApiConstants'
import { YesApiRespBean } from '../model/response/YesApiRespBean'


export function tempLogin(phone: string) {
  let user = new UserBean()
  user.phone = phone

  let body = new RequestBaseBean<UserBean>()
  body.params = user
  body.system = new SystemBean()
  body.system.sign = generateMD5Sign(body, CommonConstants.SMART_HOME_CLIENT_SECRET)

  return axiosClient.post<RespBaseBean<LoginBean>>({
    url: "2c/home/temp/login",
    baseURL: CommonConstants.SMART_HOME_BASE_URL,
    data: body
  })
}

export function getDeviceList(token?: string) {
  let body = new RequestBaseBean()
  body.system = new SystemBean()
  body.system.accessToken = token
  body.system.sign = generateMD5Sign(body, CommonConstants.SMART_HOME_CLIENT_SECRET)

  return axiosClient.post({
    url: "2c/common/user/device/list/display",
    baseURL: CommonConstants.SMART_HOME_BASE_URL,
    data: body
  })
}

export function getYesApiTable(modelName: string, id: string) {
  let body = new YesApiReqBean()
  body.service = YesApiConstants.SERVICE_TABLE_GET
  body.model_name = modelName
  body.id = id

  return axiosClient.post<YesApiRespBean>({
    url: "api/SVIP/Scc1430_MyApi/AAppTableGet",
    baseURL: YesApiConstants.BASE_URL,
    data: body
  })
}