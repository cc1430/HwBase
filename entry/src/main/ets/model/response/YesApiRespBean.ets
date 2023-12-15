export class YesApiRespBean {
  ret: number
  msg: string
  _t: number
  _auth: string
  data: YesApiData
}

class YesApiData {
  data: YesApiTableData
  err_code: number
  err_msg: string
  model_name: string
  api_version: string
}

class YesApiTableData {
  id: number
  uuid: string
  add_time: string
  update_time: string
  ext_data: string
  dev_enable: number
  playUrl: string
}