import YesApiConstants from '../../common/YesApiConstants'

export class YesApiReqBean {
  app_key: string = YesApiConstants.APP_KEY
  service: string
  return_data: string
  model_name: string
  id: string
  field_name: string
  field_value: any
}